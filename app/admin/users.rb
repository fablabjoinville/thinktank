ActiveAdmin.register User do
  TITLE = "Time interno"
  menu label: TITLE, parent: "Administração", priority: 3, if: proc { current_user.super_admin_authorization_level? }

  permit_params(
    :_destroy,
    :address,
    :authorization_level,
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
    :password_confirmation,
    :password,
    :phone_number,
    :rg
  )

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
        resource.skip_password_validation = true
      end

      super
    end
  end

  index title: TITLE do
    selectable_column

    column :image do |user|
      user.image&.attached? ? image_tag(url_for(user.image), { height: 50 }) : nil
    end
    column :full_name do |user|
      link_to user.full_name, user_path(user)
    end
    tag_column :authorization_level
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
  filter :authorization_level, as: :select, label: "Nível de autorização"

  show do
    attributes_table do
      row :full_name
      tag_row :authorization_level
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
      row :image do |user|
        user.image&.attached? ? image_tag(url_for(user.image), { height: 200 }) : nil
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :full_name
      f.input :nickname
      f.input :celular_number, input_html: { placeholder: "(XX) XXXXX-XXXX" }
      f.input :phone_number, input_html: { placeholder: "(XX) XXXX-XXXX" }
      f.input :address
      f.input :cpf, input_html: { placeholder: "XXX.XXX.XXX-XX" }
      f.input :rg, input_html: { placeholder: "X.XXX.XXX" }
      f.input :birthday, as: :datepicker, datepicker_options: { dateFormat: "dd/mm/yy" }, input_html: { placeholder: "DD/MM/AAAA" }
      f.input :gender, as: :select, collection: User.genders.keys.map { |k|
        [User.humanized_enum_value(:gender, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o gênero"
      f.input :company, as: :select, collection: Company.all.map { |c| [c.name, c.id] }, input_html: { class: "default-select" }, prompt: "Selecione a empresa"
      f.input :image, as: :file, hint: f.object&.image&.attached? ? image_tag(url_for(f.object.image), { width: 100, height: 100 }) : nil
    end

    f.inputs "Credenciais" do
      f.input :email
      f.input :authorization_level, as: :select, collection: User.authorization_levels.keys.map { |k|
        [User.humanized_enum_value(:authorization_levels, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o nível de autorização"
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
end
