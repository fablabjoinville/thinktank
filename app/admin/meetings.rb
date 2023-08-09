ActiveAdmin.register Meeting do
  menu parent: "Administração", priority: 5

  includes :phase

  permit_params(
    :_destroy,
    :id,
    :name,
    :phase_id,
  )

  index do
    selectable_column

    column :name do |meeting|
      link_to meeting.name, meeting_path(meeting)
    end
    column :phase, sortable: "phase.name"

    actions
  end

  filter :name_cont, label: "Título"
  filter :phase, as: :select, label: "Fase"

  show do
    attributes_table do
      row :name
      row :phase
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :phase, input_html: { class: "slim-select" }, prompt: "Selecione a fase"
    end

    f.actions
  end
end
