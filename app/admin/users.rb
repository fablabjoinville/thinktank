ActiveAdmin.register User do
  menu parent: "Administração", if: proc { current_user.super_admin_authorization_level? }

  permit_params :email, :authorization_level, :password, :password_confirmation, :id, :address, :birthday, :celular_number, :cpf, :full_name, :gender, :nickname, :phone_number, :rg, :_destroy

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

  index do
    selectable_column
    id_column

    column :full_name
    column :email
    column :authorization_level
    column :phone_number
    column :celular_number
    column :birthday
    column "Gênero" do |user|
      user.humanized_enum(:gender)
    end

    actions
  end

  show do
    attributes_table do
      row :full_name
      row :email
      row :authorization_level
      row :nickname
      row :phone_number
      row :celular_number
      row :address
      row :cpf
      row :rg
      row :birthday
      row "Gênero" do |user|
        user.humanized_enum(:gender)
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs "Dados pessoais" do
      f.input :full_name
      f.input :email
      f.input :nickname
      f.input :celular_number, input_html: { placeholder: "(XX) XXXXX-XXXX" }
      f.input :phone_number, input_html: { placeholder: "(XX) XXXX-XXXX" }
      f.input :address
      f.input :cpf, input_html: { placeholder: "XXX.XXX.XXX-XX" }
      f.input :rg, input_html: { placeholder: "X.XXX.XXX" }
      f.input :birthday, as: :datepicker
      f.input :gender, as: :select, collection: User.genders.keys.map { |k|
        [User.humanized_enum_value(:gender, k), k]
      }
    end

    f.inputs "Credenciais" do
      f.input :email
      f.input :authorization_level, as: :select, collection: User.authorization_levels.keys
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
end
