ActiveAdmin.register Meeting do
  menu parent: "Encontros", priority: 0

  permit_params :id, :team_id, :title, :date, :phase_id, :_destroy, attendances_attributes: [:id, :person_id, :meeting_id, :status, :reason, :_destroy]

  index do
    selectable_column

    column :title do |meeting|
      link_to meeting.title, meeting_path(meeting)
    end
    column :date
    column :phase
    column :team

    column "Participantes" do |meeting|
      meeting.attendances_counts
    end

    actions
  end

  filter :title_cont, label: "Título"
  filter :phase, as: :select, label: "Fase"
  filter :team, as: :select, label: "Equipe"

  show do
    panel "Detalhes" do
      attributes_table_for meeting do
        row :title
        row :date
        row :phase

        row "Equipe" do |meeting|
          link_to meeting.team, team_path(meeting.team)
        end
      end
    end

    panel "Avaliação do encontro (#{meeting.assessment.present? ? link_to('editar', edit_meeting_assessment_path(meeting.assessment)) : link_to('avaliar', new_meeting_assessment_path(meeting.assessment, assessment: { assessmentable_id: meeting.id }))})".html_safe do
      if meeting.assessment.present?
        attributes_table_for meeting.assessment do
          row :author
          row :item_a_assessment
          row :item_a_comment
          row :item_b_assessment
          row :item_b_comment
          row :item_c_assessment
          row :item_c_comment
          row :item_d_assessment
          row :item_d_comment
          row :general_comments
        end
      end
    end

    panel "Presença dos participantes (#{meeting.attendances_counts})" do
      attributes_table_for meeting do
        meeting.attendances.each do |attendance|
          row attendance.person.full_name do
            "#{link_to(attendance.humanized_enum(:status), attendance_path(attendance))} (#{link_to('editar', edit_attendance_path(attendance))})".html_safe
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
      f.input :date, input_html: { class: "default-select" }
      f.input :phase, input_html: { class: "slim-select" }, prompt: "Selecione a fase"
      f.input :team, input_html: { class: "slim-select" }, prompt: "Selecione a equipe"
    end

    f.actions
  end
end
