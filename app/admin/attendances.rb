require 'active_admin/views/index_as_grouped_table'

ActiveAdmin.register Attendance do
  menu parent: "Eventos", priority: 2

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

  index as: :grouped_table, group_by_attribute: :event do
    selectable_column

    column :member
    column :event
    column :team do |attendance|
      link_to attendance.event.team, team_path(attendance.event.team)
    end
    tag_column :status
    column :reason

    actions
  end

  filter :member, as: :select, label: "Membro de equipe"
  filter :event, as: :select, label: "Evento"
  filter :event_team_id, as: :select, collection: Team.all, label: "Equipe"
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
