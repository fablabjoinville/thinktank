ActiveAdmin.register Person do
  menu parent: "Administração", priority: 2, if: -> { can? :index, Person }
  config.create_another = true
  config.sort_order = 'full_name_asc'

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

  action_item :new_model, only: :show do
    localizer = ActiveAdmin::Localizers.resource(active_admin_config)
     link_to localizer.t(:new_model), new_resource_path
  end

  action_item :convert_to_user, only: :show do
    unless resource.user?
      link_to("Tornar time interno", convert_to_user_person_path(resource), data: { confirm: "Você tem certeza que deseja converter esse cadastro para Time Interno?" })
    end
  end

  member_action :convert_to_user, method: :get do
    resource.update!(type: "User")

    flash[:error] = "ADICIONE UM EMAIL E SENHA PARA O USUÁRIO!"
    redirect_to edit_user_path(resource)
  end

  index do
    selectable_column

    column :image do |person|
      image_tag(person.avatar_path, { width: 50, height: "auto" })
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

  scope "Todos" do |people|
    people.ordered_by_full_name
  end

  scope "Pessoas" do | people|
    people.internal_team.invert_where
  end

  scope "Time interno", if: -> { true } do |people|
    people.internal_team
  end


  filter :full_name_cont, label: "Nome"
  filter :nickname_cont, label: "Apelido"
  filter :cpf_eq, label: "CPF"
  filter :rg_eq, label: "RG"
  filter :company, as: :select, label: "Empresa"

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
        image_tag(person.avatar_path, { width: 200, height: "auto" })
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
      f.input :company, as: :select, collection: Company.ordered_by_name, input_html: { class: "slim-select" }, prompt: "Selecione a empresa"
      f.input :gender, as: :select, collection: Person.humanized_enum_list(:genders), input_html: { class: "default-select" }, prompt: "Selecione o gênero"
      f.input :image, as: :file, hint: image_tag(f.object.avatar_path, { width: 200, height: "auto" })
    end

    f.actions
  end
end
