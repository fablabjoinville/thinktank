ActiveAdmin.register Cluster do
  menu parent: "Equipes"

  permit_params :user_id, :start_time, :end_time, :week_day, :address, :modality, :link, team_ids: []

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

  show do
    attributes_table do
      row :id
      row :week_day do |cluster|
        cluster.humanized_enum(:week_day)
      end
      row :start_time
      row :end_time
      row :user
      tag_row :modality
      row "Equipes" do |cluster|
        if cluster.teams.any?
          ul do
            cluster.teams.each do |team|
              li link_to team, team_path(team)
            end
          end
        else
          "Este cluster possuí nenhuma equipe"
        end
      end
      row :address
      row :link
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :week_day, as: :select, collection: Cluster.week_days.keys.map { |k|
        [Cluster.humanized_enum_value(:week_day, k), k]
      }, input_html: { class: "slim-select" }, prompt: "Selecione o dia da semana"
      f.input :start_time, input_html: { class: "default-select" }, prompt: "Selecione o horário"
      f.input :end_time, input_html: { class: "default-select" }, prompt: "Selecione o horário"
      f.input :user, input_html: { class: "slim-select" }, prompt: "Selecione o facilitador"
      f.input :modality, as: :radio, collection: Cluster.modalities.keys.map { |k|
        [Cluster.humanized_enum_value(:modality, k), k]
      }#, input_html: { class: "slim-select" }, prompt: "Selecione o cluster"
      f.input :address
      f.input :link, as: :url
      f.input :team_ids, collection: Team.all, as: :tags# input_html: { class: "slim-select" }, prompt: "Selecione o eixo"
    end

    f.actions
  end
end
