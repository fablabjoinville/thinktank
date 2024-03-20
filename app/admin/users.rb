ActiveAdmin.register User do
  menu parent: "Administração", priority: 2, if: -> { can? :index, User }
  config.create_another = true
  config.sort_order = 'full_name_asc'

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
      changing_from_person_to_other = resource.person_authorization_level? && params[:user][:authorization_level] != "person"

      if !changing_from_person_to_other && params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
        resource.skip_password_validation = true
      end

      super
    end
  end

  action_item :new_model, only: :show do
    localizer = ActiveAdmin::Localizers.resource(active_admin_config)
    link_to localizer.t(:new_model), new_resource_path
  end

  index download_links: [:csv] do
    selectable_column

    column :image do |user|
      image_tag(user.avatar_path, { width: 50, height: "auto" })
    end
    column :full_name do |user|
      link_to user.full_name, user_path(user)
    end
    column :nickname
    column :email
    tag_column :authorization_level
    column :phone_number
    column :celular_number
    column :birthday
    column :company
    tag_column :gender

    actions
  end

  scope "Todos" do |user|
    user.ordered_by_full_name
  end

  scope "Pessoas" do | user|
    user.internal_team.invert_where
  end

  scope "Time interno", if: -> { true } do |user|
    user.internal_team
  end

  filter :full_name_cont, label: "Nome"
  filter :nickname_cont, label: "Apelido"
  filter :authorization_level, as: :select, label: "Nível de autorização"
  filter :cpf_eq, label: "CPF"
  filter :rg_eq, label: "RG"
  filter :company, as: :select, label: "Empresa"

  show do
    attributes_table do
      row :full_name
      row :nickname
      row :email
      tag_row :authorization_level
      row :phone_number
      row :celular_number
      row :address
      row :cpf
      row :rg
      row :birthday
      row :company
      tag_row :gender
      row :image do |user|
        image_tag(user.avatar_path, { width: 200, height: "auto" })
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
      f.input :gender, as: :select, collection: User.humanized_enum_list(:genders), input_html: { class: "default-select" }, prompt: "Selecione o gênero"
      f.input :image, as: :file, hint: image_tag(f.object.avatar_path, { width: 200, height: "auto" })

      case current_user.authorization_level.to_sym
      when :super_admin
        f.input :authorization_level, as: :select, collection: User.humanized_enum_list(:authorization_levels),
              input_html: { class: "default-select" }, prompt: "Selecione o nível de autorização"
      when :admin
        f.input :authorization_level, as: :select, collection: User.humanized_enum_list(:authorization_levels, :facilitator, :secretary),
        input_html: { class: "default-select" }, prompt: "Selecione o nível de autorização"
      end
    end

    script do
      raw "$(function() {
        console.log('aaaa')
        function showOrHidePasswordFields(element) {
          console.log(element.val());
          if (element.val() !== 'person') {
            $('#user_password_fields').show();
          } else {
            $('#user_password_fields').hide();
          }
        }

        showOrHidePasswordFields($('#user_authorization_level'));
        $('#user_authorization_level').on('change', function() {
          showOrHidePasswordFields($(this));
        });
      });"
    end

    f.inputs "Senha", id: "user_password_fields" do
      li class: "input" do
        para "Deixar em branco para não alterar a senha."
      end
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
end
