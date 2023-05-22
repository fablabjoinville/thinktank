ActiveAdmin.register Member do
  menu parent: "Equipes"

  permit_params :email, :id, :address, :birthday, :celular_number, :cpf, :full_name, :gender, :nickname, :phone_number, :rg, :team_id, :_destroy

  index do
    selectable_column
    id_column

    column :full_name
    column :email
    column :team
    column "Role" do |member|
      member.humanized_enum(:role)
    end
    column :phone_number
    column :celular_number
    column :birthday
    column "Gênero" do |member|
      member.humanized_enum(:gender)
    end
    column :active

    actions
  end

  show do
    panel "Detalhes do(a) membro de equipe ##{member.id}" do
      attributes_table_for member do
        row :full_name
        row :email
        row "Role" do |member|
          member.humanized_enum(:role)
        end
        row :team
        row :nickname
        row :phone_number
        row :celular_number
        row :address
        row :cpf
        row :rg
        row :birthday
        row "Gênero" do |member|
          member.humanized_enum(:gender)
        end
        row :active
      end
    end

    panel "Eventos (#{member.events.count})" do
      attributes_table_for member do
          if member.events.any?
            member.events.each do |event|
              row "#{event.title}" do |member|
              div link_to(event, event_path(event))
              div link_to member.attendance_status_for(event), event_path(event)
              end
            end
          else
            "Este membro não participou de nenhum evento"
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
      f.input :team, as: :select, collection: Team.all
      f.input :role, as: :select, collection: Member.roles.keys.map { |k|
        [Member.humanized_enum_value(:role, k), k]
      }
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
      }
    end

    f.actions
  end
end