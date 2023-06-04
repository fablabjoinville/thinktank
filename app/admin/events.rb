ActiveAdmin.register Event do
  menu parent: "Eventos", priority: 0

  permit_params :title, :date, :ref, :_destroy

  index do
    selectable_column

    column :title do |event|
      link_to event.title, event_path(event)
    end
    tag_column :ref

    column "Participantes" do |event|
      # event.attendances_counts
    end
    column :date

    actions
  end

  filter :title_cont, label: "Título"
  filter :ref, as: :select, label: "Ref"

  show do
    panel "Detalhes do evento ##{event.id}" do
      attributes_table_for event do
        row :title
        row :date
        tag_row :ref
      end
    end

    panel "Participantes (#{event.attendances_counts})" do
      attributes_table_for event do
        # event.team.members.each do |member|
        #   row member.full_name do
        #     attendance = member.attendances.where(event: event).first
        #     if attendance
        #       link_to attendance.humanized_enum(:status), attendance_path(attendance)
        #     else
        #       'Não registrado'
        #     end
        #   end
        # end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title
      # f.input :team, input_html: { class: "slim-select" }, prompt: "Selecione a equipe"
      f.input :ref, as: :radio
      f.input :date, as: :date_time_picker, picker_options: {
        min_date: Date.current
      }
    end

    if f.object.persisted?
      # f.inputs "Presença dos participantes" do
      #   f.has_many :attendances, heading: "", allow_destroy: true, new_record: true do |a|
      #     if a.object.new_record?
      #       a.input :member, as: :select, collection: Member.all.map { |m|
      #         [m.full_name, m.id]
      #       }
      #     else
      #       a.input :member, as: :string, input_html: { disabled: true }
      #     end
      #     a.input :status, as: :radio
      #     a.input :reason, input_html: { rows: 5 }
      #   end
      # end

      # f.inputs "Avaliação" do
      #   f.input :item_a_assessment, as: :select, collection: 1..5, input_html: { class: "default-select" }, prompt: "Selecione a avaliação"
      #   f.input :item_a_comment, input_html: { rows: 5 }
      #   f.input :item_b_assessment, as: :select, collection: 1..5, input_html: { class: "default-select" }, prompt: "Selecione a avaliação"
      #   f.input :item_b_comment, input_html: { rows: 5 }
      #   f.input :item_c_assessment, as: :select, collection: 1..5, input_html: { class: "default-select" }, prompt: "Selecione a avaliação"
      #   f.input :item_c_comment, input_html: { rows: 5 }
      #   f.input :item_d_assessment, as: :select, collection: 1..5, input_html: { class: "default-select" }, prompt: "Selecione a avaliação"
      #   f.input :item_d_comment, input_html: { rows: 5 }
      #   f.input :general_comments, input_html: { rows: 5 }
      # end
    end

    f.actions
  end
end
