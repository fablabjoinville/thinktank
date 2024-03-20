ActiveAdmin.register Company do
  menu parent: "Administração", priority: 1
  config.sort_order = 'name_asc'

  permit_params(
    :_destroy,
    :cnpj,
    :id,
    :name,
    user_ids: []
  )

  index download_links: [:csv] do
    selectable_column

    column :name do |company|
      link_to company.name, company_path(company)
    end
    column :cnpj
    column "# Pessoas" do |company|
      link_to company.users.count, users_path(q: { company_id_eq: company.id })
    end

    actions
  end

  filter :name_cont, label: "Nome"
  filter :cnpj_eq, label: "CNPJ"

  show do
    attributes_table do
      row :name
      row :cnpj
    end

    panel "Pessoas associadas: #{company.users.count}" do
      table_for company.users.ordered_by_full_name do
        column :image do |user|
          image_tag(user.avatar_path, { width: 50, height: "auto" })
        end
        column :full_name do |user|
          link_to user.full_name, user_path(user)
        end
        column :nickname
        column :email
        column :phone_number
        column :celular_number
        column :birthday
        tag_column :gender
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :cnpj, input_html: { placeholder: "XX.XXX.XXX/XXXX-XX" }
      f.input :users, as: :select, collection: User.ordered_by_full_name, label: "Pessoas"
    end

    f.actions
  end
end
