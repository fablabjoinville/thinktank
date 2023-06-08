require 'active_admin/views/index_as_grouped_table'

ActiveAdmin.register Attendance do
  menu parent: "Encontros", priority: 2

  permit_params :id, :status, :reason, :person_id, :meeting_id, :_destroy

  index as: :grouped_table, group_by_attribute: :meeting do
    selectable_column
    id_column

    column :person
    column :meeting
    column :team do |attendance|
      link_to attendance.meeting.team, team_path(attendance.meeting.team)
    end
    tag_column :status
    column :reason

    actions
  end

  filter :person, as: :select, label: "Pessoa"
  filter :meeting, as: :select, label: "Encontro"
  filter :meeting_team_id, as: :select, collection: Team.all, label: "Equipe"
  filter :status, as: :select, label: "Presença"

  show do
    panel "Detalhes" do
      attributes_table_for attendance do
        row :person
        row :meeting
        tag_row :status
        row :reason
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :person, input_html: { class: "slim-select", disabled: f.object.persisted? }, prompt: "Selecione o membro da equipe"
      f.input :meeting, input_html: { class: "slim-select", disabled: f.object.persisted? }, prompt: "Selecione o encontro"
      f.input :status, as: :radio
      f.input :reason, input_html: { rows: 5 }
    end

    f.actions
  end
end
