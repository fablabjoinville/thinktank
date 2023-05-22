ActiveAdmin.register Attendance do
  menu parent: "Eventos"

  permit_params :status, :reason, :member_id, :event_id

  index do
    selectable_column
    id_column

    column :member
    column :event
    column :status
    column :reason

    actions
  end

  form do |f|
    f.inputs do
      f.input :member, as: :select, collection: Member.all
      f.input :event, as: :select, collection: Event.all
      f.input :status
      f.input :reason
    end

    f.actions
  end

  show do
    attributes_table do
      row :member
      row :event
      row :status
      row :reason
    end

    active_admin_comments
  end
end
