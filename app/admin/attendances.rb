ActiveAdmin.register Attendance do
  menu parent: "Encontros", priority: 2

  permit_params :id, :status, :reason, :person_id, :meeting_id, :_destroy

  index do
    selectable_column
    id_column

    column :member
    column :meeting
    tag_column :status
    column :reason

    actions
  end

  filter :member, as: :select, label: "Pessoa"
  filter :meeting, as: :select, label: "Encontro"
  filter :status, as: :select, label: "Presença"

  form do |f|
    f.inputs do
      f.input :member, input_html: { class: "slim-select" }, prompt: "Selecione o membro da equipe"
      f.input :meeting, input_html: { class: "slim-select" }, prompt: "Selecione o encontro"
      f.input :status, as: :radio
      f.input :reason, input_html: { rows: 5 }
    end

    f.actions
  end

  show do
    attributes_table do
      row :member
      row :meeting
      tag_row :status
      row :reason
    end

    active_admin_comments
  end
end
