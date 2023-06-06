ActiveAdmin.register Event do
  menu parent: "Eventos", priority: 0

  permit_params :id, :title, :date, :_destroy, person_ids: []

  index do
    selectable_column

    column :title do |event|
      link_to event.title, event_path(event)
    end

    column :date

    column "Participantes" do |event|
      event.people.count
    end

    actions
  end

  filter :title_cont, label: "Título"
  filter :people, as: :select, label: "Participantes"

  show do
    panel "Detalhes" do
      attributes_table_for event do
        row :title
        row :date

        row "Participantes" do |event|
          if event.people.any?
            ul do
              event.people.map do |person|
                li link_to person.full_name, person_path(person)
              end.join.html_safe
            end
          end
        end
      end
    end

    panel "Avaliação do evento" do
      if event.assessment.present?
        attributes_table_for event.assessment do
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

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title
      f.input :date, input_html: { class: "default-select" }
      f.input :people, as: :select, input_html: { multiple: true }, prompt: "Selecione os participantes"
    end

    f.actions
  end
end
