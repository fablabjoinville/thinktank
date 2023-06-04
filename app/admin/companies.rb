ActiveAdmin.register Company do
  menu parent: "Administração", priority: 1

  permit_params :name, :cnpj, :_destroy

  index do
    selectable_column
    id_column

    column :name
    column :cnpj
    column "# Pessoas" do |company|
      company.people.count
    end

    actions
  end

  show do
    panel "Detalhes da empresa ##{company.id}" do
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
        else
          "Nenhuma pessoa associada a esta empresa"
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
    end

    f.actions
  end
end
