# t.date :birthday
# t.integer :gender, default: 2, null: false # 2 corresponds to "other"
# t.string :address, default: "", null: false
# t.string :celular_number, default: "", null: false
# t.string :cpf, default: "", null: true
# t.string :full_name, null: false
# t.string :nickname, default: "", null: false
# t.string :phone_number, default: "", null: false
# t.string :rg, default: "", null: true
# t.string :type, null: true # null is for the base Person class
# t.string :email, null: false, default: ""

ActiveAdmin.register Person do
  menu parent: "Administração", priority: 0

  permit_params :email, :id, :address, :birthday, :celular_number, :cpf, :full_name, :gender, :nickname, :phone_number, :rg, :_destroy

  index do
    selectable_column
    id_column

    column :full_name
    column :nickname
    column :email
    column :phone_number
    column :celular_number
    column :birthday
    tag_column :gender
    tag_column :type

    actions
  end

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
      f.input :gender, as: :select, collection: Member.genders.keys.map { |k|
        [Member.humanized_enum_value(:gender, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o gênero"
    end

    f.actions
  end
end
