ActiveAdmin.register Event do
  permit_params(
    :_destroy,
    :date,
    :id,
    :item_a_score,
    :item_a_comment,
    :item_b_score,
    :item_b_comment,
    :item_c_score,
    :item_c_comment,
    :item_d_score,
    :item_d_comment,
    :general_comments,
    :meeting_id,
    :name,
    :team_id,
    attendances_attributes: [
      :id,
      :member_id,
      :reason,
      :status
    ],
    tool_event_assessments_attributes: [
      :_destroy,
      :comment,
      :event_id,
      :id,
      :score,
      :tool_id
    ]
  )

  controller do
    def build_new_resource
        resource = super
        resource.assign_attributes(team_id: params[:team_id]) if params[:team_id].present?
        resource
    end
  end

  index download_links: false do
    selectable_column

    column :name do |event|
      link_to event.name, event_path(event)
    end
    column :date
    column :team

    actions
  end

  filter :meeting, label: "Encontro"
  filter :date
  filter :team, label: "Equipe"

  show do
    columns do
      column min_width: "35%", max_width: "35%" do
        attributes_table do
          row :name
          row :date
          row :team
        end

        panel "Avaliação do evento" do
          table_for event.assessment do
            column "Item" do |assessment|
              assessment[:item]
            end
            column "Avaliação" do |assessment|
              if assessment[:score]
                Event.humanized_enum_value(:score, assessment[:score])
              else
                "-"
              end
            end
            column "Comentário" do |assessment|
              assessment[:comment]
            end
          end
          attributes_table_for event do
            row :general_comments
          end
        end

        panel "Avaliação de ferramentas: #{event.tool_event_assessments.count}" do
          table_for event.tool_event_assessments.joins(:tool).order('tool.name ASC') do
            column :tool
            tag_column :score
            column :comment
          end
        end
      end

      column min_width: "63%", max_width: "63%" do
        panel "Participantes: #{event.attendances_counts}" do
          table_for event.attendances.joins(member: :user).order('users.full_name ASC') do
            column do |attendance|
              image_tag(attendance.avatar_path, { width: 50, height: "auto" })
            end
            column :member do |attendance|
              link_to attendance.full_name, event_attendance_path(attendance.event, attendance)
            end
            tag_column :role do |attendance|
              attendance.member.role
            end
            column "telefone" do |attendance|
              attendance.celular_number || attendance.phone_number
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
      end
    end

    active_admin_comments
  end

  form do |f|
  f.semantic_errors

    columns do
      column do
        f.inputs do
          f.input :meeting, as: :select, collection: Meeting.ordered_by_name, input_html: { class: "slim-select" }, prompt: "Selecione o Encontro"
          f.input :date, input_html: { class: "default-select" }
          f.input :team, as: :select, collection: Team.accessible_by(current_ability).ordered_by_name,  input_html: { class: "slim-select" }, prompt: "Selecione a Equipe"
        end

        unless f.object.new_record?
          f.inputs "Avaliação do evento" do
            f.input :item_a_score, as: :radio, collection: Event.humanized_enum_list(:item_a_scores)
            f.input :item_a_comment, input_html: { rows: 5 }
            f.input :item_b_score, as: :radio, collection: Event.humanized_enum_list(:item_b_scores)
            f.input :item_b_comment, input_html: { rows: 5 }
            f.input :item_c_score, as: :radio, collection: Event.humanized_enum_list(:item_c_scores)
            f.input :item_c_comment, input_html: { rows: 5 }
            f.input :item_d_score, as: :radio, collection: Event.humanized_enum_list(:item_d_scores)
            f.input :item_d_comment, input_html: { rows: 5 }
            f.input :general_comments, input_html: { rows: 5 }
          end

          f.inputs "Avaliação de ferramentas: #{f.object.tool_event_assessments.count}", style: "padding-top: 0" do
            f.has_many :tool_event_assessments, heading: '', allow_destroy: true, new_record: true do |a|
              a.input :tool, input_html: { class: "slim-select" }, prompt: "Selecione a ferramenta"
              a.input :score, as: :radio, collection: ToolEventAssessment.humanized_enum_list(:scores)
              a.input :comment, input_html: { rows: 5 }
            end
          end
        end

        f.actions
      end

      unless f.object.new_record?
        column do
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
    end
  end
end
