ActiveAdmin.register Assessment, as: "EventAssessment" do
  menu parent: "Eventos", priority: 1

  controller do
    def scoped_collection
      end_of_association_chain.where(assessmentable_type: "Event")
    end
  end

  permit_params :id, :assessmentable_id, :assessmentable_type, :author_id, :author_type, :item_a_assessment, :item_a_comment, :item_b_assessment, :item_b_comment, :item_c_assessment, :item_c_comment, :item_d_assessment, :item_d_comment, :general_comments, :_destroy

    index do
      selectable_column
      id_column

      column :assessmentable
      column :author
      column :item_a_assessment
      column :item_b_assessment
      column :item_c_assessment
      column :item_d_assessment

      actions
    end

    filter :author_id, as: :select, label: "Avaliador"
    filter :assessmentable_id, as: :select, label: "Evento"

    show do
      panel "Avaliação do evento" do
        attributes_table_for event_assessment do
          row "Evento" do |event_assessment|
            link_to event_assessment.assessmentable.title, event_path(event_assessment.assessmentable)
          end
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

    form do |f|
      f.semantic_errors

      f.inputs "Evento" do
        f.input :assessmentable_id, as: :select, collection: Event.all, label: "Evento", prompt: "Selecione o evento", input_html: { disabled: f.object.persisted? }
        f.input :assessmentable_type, as: :hidden, input_html: { value: 'Event' }
        f.input :author_id, as: :hidden, input_html: { value: current_user.id }
        f.input :author_type, as: :hidden, input_html: { value: current_user.class }
      end

      f.inputs "Avaliação" do
        f.input :item_a_assessment, as: :select, collection: 1..5, input_html: { class: "default-select" }, prompt: "Selecione a avaliação"
        f.input :item_a_comment, input_html: { rows: 5 }
        f.input :item_b_assessment, as: :select, collection: 1..5, input_html: { class: "default-select" }, prompt: "Selecione a avaliação"
        f.input :item_b_comment, input_html: { rows: 5 }
        f.input :item_c_assessment, as: :select, collection: 1..5, input_html: { class: "default-select" }, prompt: "Selecione a avaliação"
        f.input :item_c_comment, input_html: { rows: 5 }
        f.input :item_d_assessment, as: :select, collection: 1..5, input_html: { class: "default-select" }, prompt: "Selecione a avaliação"
        f.input :item_d_comment, input_html: { rows: 5 }
        f.input :general_comments, input_html: { rows: 5 }
      end

      f.actions
    end
  end