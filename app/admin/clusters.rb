ActiveAdmin.register Cluster do
  menu priority: 2

  permit_params(
    :_destroy,
    :active,
    :address,
    :chapter_id,
    :end_date,
    :end_time,
    :id,
    :link,
    :person_id,
    :start_date,
    :start_time,
    :week_day,
    team_ids: []
  )

  index download_links: false do
    selectable_column
    id_column

    column "Dia da semana" do |cluster|
      link_to cluster.humanized_enum(:week_day), cluster_path(cluster)
    end
    column :chapter
    column :start_date
    column :end_date
    column :start_time
    column :end_time
    column :user
    column :teams do |cluster|
      link_to cluster.teams.count, teams_path(q: { id_in: cluster.team_ids })
    end
    column :address
    column :link do |cluster|
      link_to cluster.link, cluster.link, target: "_blank"
    end
    column :active

    actions
  end

  filter :week_day, as: :select, label: "Dia da semana"
  filter :user, as: :select, label: "Facilitador"

  show do
    attributes_table do
      row :chapter
      row :week_day do |cluster|
        cluster.humanized_enum(:week_day)
      end
      row :start_date
      row :end_date
      row :start_time
      row :end_time
      row :user
      row :address
      row :link do |cluster|
        link_to cluster.link, cluster.link, target: "_blank"
      end
      row :active
    end

    panel "Equipes: #{cluster.teams.count}" do
      table_for cluster.teams.ordered_by_name do
        column :name do |team|
          link_to team, team_path(team)
        end
        tag_column "Modalidade" do |team|
          team.modality
        end
        column "Miro" do |team|
          link_to "Miro: #{team.name}", team.link_miro if team.link_miro.present?
        end
        column "Sala Teams" do |team|
          link_to "Sala Teams: #{team.name}", team.link_teams if team.link_teams.present?
        end
        column "Membros" do |team|
          link_to team.members.count, team_path(team)
        end
        column "Eventos" do |team|
          link_to team.events.count, team_path(team)
        end
        column :axis
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :chapter, as: :select, collection: Chapter.year_and_title_options, input_html: { class: "slim-select" }, prompt: "Selecione o capítulo"
      f.input :week_day, as: :select, collection: Cluster.humanized_enum_list(:week_days), input_html: { class: "default-select" }, prompt: "Selecione o dia da semana"
      f.input :start_date, as: :date_time_picker, picker_options: { datepicker: true, timepicker: false, format: "Y-m-d" }
      f.input :end_date, as: :date_time_picker, picker_options: { datepicker: true, timepicker: false, format: "Y-m-d" }
      f.input :start_time, as: :date_time_picker, picker_options: { datepicker: false, timepicker: true, format: "H:i" }
      f.input :end_time, as: :date_time_picker, picker_options: { datepicker: false, timepicker: true, format: "H:i" }
      f.input :user, input_html: { class: "slim-select" }, prompt: "Selecione o facilitador"
      f.input :address
      f.input :link, as: :url
      f.input :teams, as: :select, collection: Team.ordered_by_name, input_html: { class: "sim-select" }, prompt: "Selecione as equipes", multiple: true
      f.input :active, as: :boolean
    end

    f.actions
  end
end
