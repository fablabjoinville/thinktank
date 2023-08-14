ActiveAdmin.register Attendance do
  belongs_to :event

  permit_params(
    :_destroy,
    :event_id,
    :id,
    :member_id,
    :reason,
    :status,
  )

  member_action :mark_as_present, method: :put do
    resource.update!(status: :present)

    redirect_to event_path(resource.event)
  end

  index do
    selectable_column

    column :member
    column :team do |attendance|
      link_to attendance.event.team, team_path(attendance.event.team)
    end
    tag_column :status
    column :reason

    actions
  end

  filter :member, as: :select, collection: -> { @event.members }, label: "Membro de equipe"
  filter :status, as: :select, label: "Presença"

  show do
    panel "Detalhes" do
      attributes_table_for attendance do
        row :member
        row :event
        tag_row :status
        row :reason
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :member, input_html: { class: "slim-select", disabled: f.object.persisted? }, prompt: "Selecione o membro da equipe"
      f.input :event, input_html: { class: "slim-select", disabled: f.object.persisted? }, prompt: "Selecione o encontro"
      f.input :status, as: :radio
      f.input :reason, input_html: { rows: 5 }
    end

    f.actions
  end
end
