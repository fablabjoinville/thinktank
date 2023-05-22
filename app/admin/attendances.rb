ActiveAdmin.register Attendance do
  menu parent: "Eventos"

  permit_params :status, :reason, :member_id, :event_id

  index do
    selectable_column
    id_column

    column :member
    column :event
    tag_column :status
    column :reason

    actions
  end

  form do |f|
    f.inputs do
      f.input :member, input_html: { class: "slim-select" }, prompt: "Selecione o membro da equipe"
      f.input :event, input_html: { class: "slim-select" }, prompt: "Selecione o evento"
      f.input :status, as: :radio
      f.input :reason, input_html: { rows: 5 }
    end

    f.actions
  end

  show do
    attributes_table do
      row :member
      row :event
      tag_row :status
      row :reason
    end

    active_admin_comments
  end
end
