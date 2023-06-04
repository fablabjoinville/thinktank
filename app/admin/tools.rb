ActiveAdmin.register Tool do
  menu parent: "Administração"

  permit_params :name

  index do
    selectable_column

    column :name do |tool|
      link_to tool.name, tool_path(tool)
    end

    actions
  end

  filter :name_cont, label: "Nome"

  show do
    attributes_table do
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
