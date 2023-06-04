ActiveAdmin.register Meeting do
  menu parent: "Encontros", priority: 0

  permit_params :team_id, :title, :date, :ref, attendances_attributes: [:id, :person_id, :meeting_id, :status, :reason, :_destroy]

  index do
    selectable_column

    column :title do |meeting|
      link_to meeting.title, meeting_path(meeting)
    end
    column :team
    tag_column :ref

    column "Participantes" do |meeting|
      meeting.attendances_counts
    end
    column :date

    actions
  end

  filter :title_cont, label: "Título"
  filter :team, as: :select, label: "Equipe"
  filter :ref, as: :select, label: "Ref"

  show do
    panel "Detalhes do encontro ##{meeting.id}" do
      attributes_table_for meeting do
        row :title
        row :date
        tag_row :ref
        row "Equipe" do |meeting|
          link_to meeting.team, team_path(meeting.team)
        end
      end
    end

    panel "Participantes (#{meeting.attendances_counts})" do
      attributes_table_for meeting do
        meeting.attendances.each do |attendance|
          row attendance.member.full_name do
            link_to attendance.humanized_enum(:status), attendance_path(attendance)
          end
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title
      f.input :team, input_html: { class: "slim-select" }, prompt: "Selecione a equipe"
      f.input :ref, as: :radio
      f.input :date, as: :date_time_picker, picker_options: {
        min_date: Date.current
      }
    end

    if f.object.persisted?
      f.inputs "Presença dos participantes" do
        f.has_many :attendances, heading: "", allow_destroy: true, new_record: true do |a|
          if a.object.new_record?
            a.input :member, as: :select, collection: Member.all.map { |m|
              [m.full_name, m.id]
            }
          else
            a.input :member, as: :string, input_html: { disabled: true }
          end
          a.input :status, as: :radio
          a.input :reason, input_html: { rows: 5 }
        end
      end
    end

    f.actions
  end
end
