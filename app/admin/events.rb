ActiveAdmin.register Event do
  permit_params(
    :_destroy,
    :date,
    :id,
    :meeting_id,
    :name,
    :team_id
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

  show do
    attributes_table do
      row :name
      row :date
      row :meeting
      row :team

    end
  end

  form do |f|
  f.semantic_errors

      f.inputs do
        f.input :name
        f.input :date, input_html: { class: "default-select" }
        f.input :meeting, as: :select, collection: Meeting.ordered_by_name, input_html: { class: "slim-select" }, prompt: "Selecione o Encontro"
        f.input :team, as: :select, collection: Team.ordered_by_name,  input_html: { class: "slim-select" }, prompt: "Selecione a Equipe"
      end

      f.actions
    end
  end
