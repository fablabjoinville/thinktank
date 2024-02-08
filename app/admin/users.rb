ActiveAdmin.register User do
  TITLE = "Time interno"
  menu label: TITLE, parent: "Administração", priority: 3, if: -> { can? :index, User }
  config.sort_order = 'full_name_asc'

  permit_params(
    :_destroy,
    :authorization_level,
    :email,
    :id,
    :password_confirmation,
    :password,
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
      image_tag(user.avatar_path, { width: 50, height: "auto" })
    end
    column :full_name do |user|
      link_to user.full_name, user_path(user)
    end
    tag_column :authorization_level
    column :email

    actions
  end

  filter :full_name_cont, label: "Nome"
  filter :authorization_level, as: :select, label: "Nível de autorização"

  show do
    attributes_table do
      row :full_name
      tag_row :authorization_level
      row :email
      row :image do |user|
        image_tag(user.avatar_path, { width: 200, height: "auto" })
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs "Editar credenciais: #{object.full_name}" do
      f.input :email

      case current_user.authorization_level.to_sym
      when :super_admin
        f.input :authorization_level, as: :select, collection: Person.humanized_enum_list(:authorization_levels),
              input_html: { class: "default-select" }, prompt: "Selecione o nível de autorização"
      when :admin
        f.input :authorization_level, as: :select, collection: Person.humanized_enum_list(:authorization_levels, :facilitator, :secretary),
        input_html: { class: "default-select" }, prompt: "Selecione o nível de autorização"
      end

      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
end
