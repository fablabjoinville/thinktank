ActiveAdmin.register Axis do
  menu parent: "Equipes"

  permit_params :title, :description

  index do
    selectable_column
    id_column

    column :title
    column :description

    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :description
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title, input_html: { placeholder: "Título" }
      f.input :description
    end

    f.actions
  end
end
