ActiveAdmin.register Company do
  menu parent: "Administração", priority: 2

  permit_params :id, :name, :cnpj, :_destroy, person_ids: []

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
    panel "Detalhes" do
      attributes_table_for company do
        row :name
        row :cnpj
      end
    end

    panel "Pessoas associadas ##{company.people.count}" do
      attributes_table_for company do
        if company.people.any?
          ul do
            company.people.each do |person|
              li link_to(person, person_path(person))
            end
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
