ActiveAdmin.register Person do
  menu parent: "Administração", priority: 2

  permit_params(
    :_destroy,
    :address,
    :birthday,
    :celular_number,
    :company_id,
    :cpf,
    :email,
    :full_name,
    :gender,
    :id,
    :image,
    :nickname,
    :phone_number,
    :rg,
  )

  index do
    selectable_column

    column :image do |person|
      person.image&.attached? ? image_tag(url_for(person.image), { height: 50 }) : nil
    end
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

  action_item :new_model, only: :show do
    localizer = ActiveAdmin::Localizers.resource(active_admin_config)
     link_to localizer.t(:new_model), new_resource_path
  end

  show do
    attributes_table do
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
      row :image do |person|
        person.image&.attached? ? image_tag(url_for(person.image), { height: 200 }) : nil
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
      f.input :birthday, as: :datepicker, datepicker_options: {dateFormat: "dd/mm/yy" }, input_html: { placeholder: "DD/MM/AAAA" }
      f.input :company, as: :select, collection: Company.all.map { |c| [c.name, c.id] }.sort, input_html: { class: "slim-select" }, prompt: "Selecione a empresa"
      f.input :gender, as: :select, collection: Person.genders.keys.map { |k|
        [Person.humanized_enum_value(:gender, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o gênero"
      f.input :image, as: :file, hint: f.object&.image&.attached? ? image_tag(url_for(f.object.image), { width: 100, height: 100 }) : nil
    end

    f.actions
  end
end
