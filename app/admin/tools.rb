ActiveAdmin.register Tool do
  menu parent: "Administração"

  permit_params :name

  index do
    selectable_column
    id_column

    column :name

    actions
  end

  show do
    attributes_table do
      row :id
      row :name
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
    end

    f.actions
  end
end
