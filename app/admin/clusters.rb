ActiveAdmin.register Cluster do
  menu priority: 2

  permit_params(
    :_destroy,
    :active,
    :address,
    :end_date,
    :end_time,
    :id,
    :link,
    :modality,
    :person_id,
    :start_date,
    :start_time,
    :week_day,
    team_ids: []
  )

  index do
    selectable_column
    id_column

    column "Dia da semana" do |cluster|
      cluster.humanized_enum(:week_day)
    end
    column :start_date
    column :end_date
    column :start_time
    column :end_time
    column :user
    tag_column :modality
    column "Equipes" do |cluster|
      cluster.teams.count
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
      row :week_day do |cluster|
        cluster.humanized_enum(:week_day)
      end
      row :start_date
      row :end_date
      row :start_time
      row :end_time
      row :user
      tag_row :modality
      row :address
      row :link do |cluster|
        link_to cluster.link, cluster.link, target: "_blank"
      end
      row :active
    end

    panel "Equipes: #{cluster.teams.count}" do
      if cluster.teams.any?
        cluster.teams.ordered_by_name.each do |team|
          div link_to team, team_path(team)
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :week_day, as: :select, collection: Cluster.humanized_enum_list(:week_days), input_html: { class: "default-select" }, prompt: "Selecione o dia da semana"
      f.input :start_date, as: :date_time_picker, picker_options: { datepicker: true, timepicker: false, format: "Y-m-d" }
      f.input :end_date, as: :date_time_picker, picker_options: { datepicker: true, timepicker: false, format: "Y-m-d" }
      f.input :start_time, as: :date_time_picker, picker_options: { datepicker: false, timepicker: true, format: "H:i" }
      f.input :end_time, as: :date_time_picker, picker_options: { datepicker: false, timepicker: true, format: "H:i" }
      f.input :user, input_html: { class: "slim-select" }, prompt: "Selecione o facilitador"
      f.input :modality, as: :radio, collection: Cluster.humanized_enum_list(:modalities)
      f.input :address
      f.input :link, as: :url
      f.input :teams, as: :select, collection: Team.ordered_by_name, input_html: { class: "sim-select" }, prompt: "Selecione as equipes", multiple: true
      f.input :active, as: :boolean
    end

    f.actions
  end
end
