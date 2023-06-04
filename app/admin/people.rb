ActiveAdmin.register Person do
  menu parent: "Administração", priority: 0

  permit_params :email, :id, :address, :birthday, :celular_number, :cpf, :full_name, :gender, :nickname, :phone_number, :rg, :company_id, :_destroy

  index do
    selectable_column

    column :full_name do |person|
      link_to person.full_name, person_path(person)
    end
    column :nickname
    column :email
    column :phone_number
    column :celular_number
    column :birthday
    column :company
    tag_column :gender

    actions
  end

  filter :full_name_cont, label: "Nome"
  filter :nickname_cont, label: "Apelido"
  filter :cpf_eq, label: "CPF"
  filter :rg_eq, label: "RG"
  filter :company, as: :select, label: "Empresa"
  filter :active, as: :select, collection: [["Ativo", true], ["Inativo", false]], label: "Ativo"

  show do
    panel "Detalhes da pessoa ##{person.id}" do
      attributes_table_for person do
        row :full_name
        row :nickname
        row :email
        row :phone_number
        row :celular_number
        row :address
        row :cpf
        row :rg
        row :birthday
        row :company
        tag_row :gender
        tag_row :type
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :full_name
      f.input :email
      f.input :nickname
      f.input :celular_number, input_html: { placeholder: "(XX) XXXXX-XXXX" }
      f.input :phone_number, input_html: { placeholder: "(XX) XXXX-XXXX" }
      f.input :address
      f.input :cpf, input_html: { placeholder: "XXX.XXX.XXX-XX" }
      f.input :rg, input_html: { placeholder: "X.XXX.XXX" }
      f.input :birthday, as: :datepicker
      f.input :company, as: :select, collection: Company.all.map { |c| [c.name, c.id] }, input_html: { class: "default-select" }, prompt: "Selecione a empresa"
      f.input :gender, as: :select, collection: Member.genders.keys.map { |k|
        [Member.humanized_enum_value(:gender, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o gênero"
    end

    f.actions
  end
end
