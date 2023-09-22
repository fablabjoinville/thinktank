ActiveAdmin.register Event do
  permit_params(
    :_destroy,
    :date,
    :id,
    :meeting_id,
    :name,
    :team_id,
    attendances_attributes: [
      :id,
      :member_id,
      :reason,
      :status
    ]
  )

  index do
    selectable_column

    column :name do |event|
      link_to event.name, event_path(event)
    end
    column :date
    column :meeting
    column :team

    actions
  end

  filter :name_cont, label: "Título"
  filter :date
  filter :meeting, label: "Encontro"
  filter :team, label: "Equipe"

  sidebar "Links", only: [:show] do
    ul do
      li link_to "Lista de presenças", event_attendances_path(event)
    end
  end

  show do
    attributes_table do
      row :name
      row :date
      row :meeting
      row :team
    end

    panel "Participantes #{event.attendances_counts}" do
      table_for event.attendances.joins(member: :person).order('person.full_name ASC') do
        column do |attendance|
          image_tag(attendance.avatar_path, { width: 50, height: "auto" })
        end
        column :member do |attendance|
          link_to attendance.full_name, event_attendance_path(attendance.event, attendance)
        end
        column :email do |attendance|
          attendance.email
        end
        column "celular" do |attendance|
          attendance.celular_number
        end
        column "telefone" do |attendance|
          attendance.phone_number
        end
        tag_column :status
        column :reason
        column "Ações" do |attendance|
          ul class: "actions" do
            li do
              link_to "Presente", update_status_event_attendance_path(event, attendance, status: :present), method: :put
            end
            li do
              link_to "Ausente", update_status_event_attendance_path(event, attendance, status: :absent ), method: :put
            end
            li do
              link_to "Justificar", edit_event_path(event)
            end
          end
        end
      end
    end

    active_admin_comments
  end

  form do |f|
  f.semantic_errors

      f.inputs do
        f.input :name
        f.input :date, input_html: { class: "default-select" }
        f.input :meeting, as: :select, collection: Meeting.ordered_by_name, input_html: { class: "slim-select" }, prompt: "Selecione o Encontro"
        f.input :team, as: :select, collection: Team.accessible_by(current_ability).ordered_by_name,  input_html: { class: "slim-select" }, prompt: "Selecione a Equipe"
      end

      f.inputs "Participantes: #{f.object.attendances_counts}", style: "padding-top: 0" do
        f.has_many :attendances, heading: "", new_record: false do |a|
          a.input :member, input_html: { class: "slim-select", disabled: a.object.persisted? }, prompt: "Selecione o membro da equipe"
          a.input :status, as: :radio, collection: Attendance.humanized_enum_list(:statuses)
          a.input :reason, input_html: { rows: 5 }
        end
      end

      f.actions
    end
  end
