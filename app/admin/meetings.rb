ActiveAdmin.register Meeting do
  menu parent: "Encontros", priority: 0

  permit_params :team_id, :title, :date, attendances_attributes: [:id, :person_id, :meeting_id, :status, :reason, :_destroy]

  index do
    selectable_column

    column :title do |meeting|
      link_to meeting.title, meeting_path(meeting)
    end
    column :date
    column :team

    column "Participantes" do |meeting|
      meeting.attendances_counts
    end

    actions
  end

  filter :title_cont, label: "Título"
  filter :team, as: :select, label: "Equipe"

  show do
    panel "Detalhes" do
      attributes_table_for meeting do
        row :title
        row :date

        row "Equipe" do |meeting|
          link_to meeting.team, team_path(meeting.team)
        end
      end
    end

    panel "Avaliação do encontro" do
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
      f.input :date, input_html: { class: "default-select" }
      f.input :team, input_html: { class: "slim-select" }, prompt: "Selecione a equipe"
    end

    f.actions
  end
end
