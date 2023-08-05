ActiveAdmin.register Team do
  menu priority: 4

  permit_params(
    :_destroy,
    :axis_id,
    :clusters,
    :id,
    :link_miro,
    :link_teams,
    :name,
    cluster_ids: [],
    person_ids: []
  )

  index do
    selectable_column

    column :name do |team|
      link_to team.name, team_path(team)
    end
    column "Miro" do |team|
      link_to "Miro: #{team.name}", team.link_miro
    end
    column "Sala Teams" do |team|
      link_to "Sala Teams: #{team.name}", team.link_teams
    end
    column "Clusters" do |team|
      team.clusters.count
    end
    column "Membros" do |team|
      team.members.count
    end
    column :axis
    column :created_at

    actions
  end

  filter :name_cont, label: "Nome"
  filter :clusters, as: :select, label: "Clusters"
  filter :axis, as: :select, label: "Eixo"

  show do
    attributes_table do
      row :name
      row :axis
      row "Miro" do |team|
        if team.link_miro.present?
          link_to team.link_miro, team.link_miro
        end
      end
      row "MS Teams" do |team|
        if team.link_teams.present?
          link_to team.link_teams, team.link_teams
        end
      end
      row "Membros" do |team|
        if team.members.any?
          ul do
            team.members.each do |member|
              li link_to member, member_path(member)
            end
          end
        end
      end
      row "Clusters" do |team|
        if team.clusters.any?
          ul do
            team.clusters.each do |cluster|
              li link_to cluster, cluster_path(cluster)
            end
          end
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :link_miro
      f.input :link_teams
      f.input :axis, input_html: { class: "slim-select" }, prompt: "Selecione o eixo"
      f.input :cluster_ids, collection: Cluster.all, as: :tags, display_name: :to_s, hint: "Selecione os clusters"
      f.input :person_ids, collection: Person.all, as: :tags, display_name: :to_s, hint: "Selecione os membros da equipe. Todos serão adicionados como solucionadores."
    end

    f.actions
  end
end
