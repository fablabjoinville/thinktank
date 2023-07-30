ActiveAdmin.register Company do
  menu parent: "Administração", priority: 1

  permit_params(
    :_destroy,
    :cnpj,
    :id,
    :name,
    person_ids: []
  )

  index do
    selectable_column

    column :name do |company|
      link_to company.name, company_path(company)
    end
    column :cnpj
    column "# Pessoas" do |company|
      company.people.count
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

    panel "Pessoas associadas: #{company.people.count}" do
      attributes_table_for company do
        if company.people.any?
          company.people.each do |person|
            div link_to(person, person_path(person))
          end
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :cnpj, input_html: { placeholder: "XX.XXX.XXX/XXXX-XX" }
      f.input :people, as: :select, collection: Person.all, label: "Pessoas"
    end

    f.actions
  end
end
