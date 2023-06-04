ActiveAdmin.register Member do
  menu parent: "Equipes", priority: 1

  permit_params :email, :id, :address, :birthday, :celular_number, :cpf, :full_name, :gender, :nickname, :phone_number, :rg, :team_id, :_destroy

  index do
    selectable_column

    column :full_name do |member|
      link_to member.full_name, member_path(member)
    end
    column :email
    column :team
    tag_column :role
    column :phone_number
    column :celular_number
    column :birthday
    tag_column :gender
    column :active

    actions
  end

  filter :full_name_cont, label: "Nome"
  filter :nickname_cont, label: "Apelido"
  filter :cpf_eq, label: "CPF"
  filter :rg_eq, label: "RG"
  filter :active, as: :select, collection: [["Ativo", true], ["Inativo", false]], label: "Ativo"
  filter :role, as: :select, label: "Role"
  filter :team, as: :select, label: "Equipe"
  filter :company, as: :select, label: "Empresa"

  show do
    panel "Detalhes do(a) membro de equipe ##{member.id}" do
      attributes_table_for member do
        row :full_name
        row :email
        tag_row :role
        row :team
        row :nickname
        row :phone_number
        row :celular_number
        row :address
        row :cpf
        row :rg
        row :birthday
        tag_row :gender
        row :active
      end
    end

    panel "Encontros (#{member.meetings.count})" do
      attributes_table_for member do
        if member.meetings.any?
          member.meetings.each do |meeting|
            row "#{meeting.title}" do |member|
            div link_to(meeting, meeting_path(meeting))
            div link_to member.attendance_status_for(meeting), meeting_path(meeting)
            end
          end
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :full_name
      f.input :email
      f.input :team, as: :select, prompt: "Selecione a equipe"
      f.input :role, as: :select, collection: Member.roles.keys.map { |k|
        [Member.humanized_enum_value(:role, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o role"
      f.input :active
      f.input :nickname
      f.input :celular_number, input_html: { placeholder: "(XX) XXXXX-XXXX" }
      f.input :phone_number, input_html: { placeholder: "(XX) XXXX-XXXX" }
      f.input :address
      f.input :cpf, input_html: { placeholder: "XXX.XXX.XXX-XX" }
      f.input :rg, input_html: { placeholder: "X.XXX.XXX" }
      f.input :birthday, as: :datepicker
      f.input :gender, as: :select, collection: Member.genders.keys.map { |k|
        [Member.humanized_enum_value(:gender, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o gênero"
    end

    f.actions
  end
end
