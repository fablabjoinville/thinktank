ActiveAdmin.register Meeting do
  menu parent: "Encontros", priority: 0

  permit_params :id, :name, :phase_id, :_destroy

  index do
    selectable_column

    column :name do |meeting|
      link_to meeting.name, meeting_path(meeting)
    end
    column :phase

    actions
  end

  filter :name_cont, label: "Título"
  filter :phase, as: :select, label: "Fase"

  show do
    panel "Detalhes" do
      attributes_table_for meeting do
        row :name
        row :phase
      end
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
