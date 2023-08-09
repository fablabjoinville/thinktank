ActiveAdmin.register Axis do
  menu priority: 3
  config.sort_order = 'name_asc'

  permit_params(
    :_destroy,
    :description,
    :id,
    :title,
  )

  index do
    selectable_column

    column :title do |axis|
      link_to axis.title, axis_path(axis)
    end
    column :description

    actions
  end

  filter :title_cont, label: "Título"

  show do
    attributes_table do
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
