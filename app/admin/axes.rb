ActiveAdmin.register Axis do
  menu priority: 3
  config.sort_order = 'title_asc'

  permit_params(
    :_destroy,
    :description,
    :id,
    :title,
  )

  index do
    selectable_column

    column :title do |axis|
      link_to axis.title, axis_path(axis)
    end
    column :description

    actions
  end

  filter :title_cont, label: "Título"

  show do
    attributes_table do
      row :title
      row :description
    end

    panel "Equipes #{axis.teams.count}" do
      table_for axis.teams.ordered_by_name do
        column :name do |team|
          link_to team, team_path(team)
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
        column "Clusters" do |team|
          team.clusters.count
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title, input_html: { placeholder: "Título" }
      f.input :description
    end

    f.actions
  end
end
