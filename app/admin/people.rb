ActiveAdmin.register Person do
  menu parent: "Administração"

  permit_params :email, :id, :address, :birthday, :celular_number, :cpf, :full_name, :gender, :nickname, :phone_number, :rg, :_destroy

  index do
    selectable_column
    id_column

    column :full_name
    column :email
    column :phone_number
    column :celular_number
    column :birthday
    tag_column :gender

    actions
  end

  show do
    panel "Detalhes da pessoa ##{person.id}" do
      attributes_table_for person do
        row :full_name
        row :email
        row :nickname
        row :phone_number
        row :celular_number
        row :address
        row :cpf
        row :rg
        row :birthday
        tag_row :gender
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
      f.input :gender, as: :select, collection: Member.genders.keys.map { |k|
        [Member.humanized_enum_value(:gender, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o gênero"
    end

    f.actions
  end
end
