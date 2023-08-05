ActiveAdmin.register Cluster do
  menu priority: 2

  permit_params(
    :_destroy,
    :address,
    :end_time,
    :id,
    :link,
    :modality,
    :person_id,
    :start_time,
    :week_day,
  )

  index do
    selectable_column
    id_column

    column "Dia da semana" do |cluster|
      cluster.humanized_enum(:week_day)
    end
    column :start_time
    column :end_time
    column :user
    tag_column :modality
    column "Equipes" do |cluster|
      cluster.teams.count
    end
    column :address
    column :link

    actions
  end

  filter :week_day, as: :select, label: "Dia da semana"
  filter :user, as: :select, label: "Facilitador"

  show do
    attributes_table do
      row :week_day do |cluster|
        cluster.humanized_enum(:week_day)
      end
      row :start_time
      row :end_time
      row :user
      tag_row :modality
      row :address
      row :link
    end

    panel "Equipes: #{cluster.teams.count}" do
      if cluster.teams.any?
        cluster.teams.each do |team|
          div link_to team, team_path(team)
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :week_day, as: :select, collection: Cluster.week_days.keys.map { |k|
        [Cluster.humanized_enum_value(:week_day, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o dia da semana"
      f.input :start_time, input_html: { class: "slim-select" }, prompt: "Selecione o horário"
      f.input :end_time, input_html: { class: "default-select" }, prompt: "Selecione o horário"
      f.input :user, input_html: { class: "slim-select" }, prompt: "Selecione o facilitador"
      f.input :modality, as: :radio, collection: Cluster.modalities.keys.map { |k|
        [Cluster.humanized_enum_value(:modality, k), k]
      }
      f.input :address
      f.input :link, as: :url
    end

    f.actions
  end
end
