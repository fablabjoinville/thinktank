ActiveAdmin.register Team do
  menu parent: "Equipes"

  permit_params :name, :link_miro, :link_teams, :axis_id, member_ids: [], cluster_ids: []

  index do
    selectable_column
    id_column

    column :name
    column "Miro" do |team|
      link_to team.link_miro, team.link_miro
    end
    column "MS Teams" do |team|
      link_to team.link_teams, team.link_teams
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

  show do
    attributes_table do
      row :id
      row :name
      row "Miro" do |team|
        link_to team.link_miro, team.link_miro
      end
      row "MS Teams" do |team|
        link_to team.link_teams, team.link_teams
      end
      row "Membros" do |team|
        if team.members.any?
          ul do
            team.members.each do |member|
              li link_to member.full_name, member_path(member)
            end
          end
        else
          "Esta equipe não está em nenhum membro"
        end
      end
      row "Clusters" do |team|
        if team.clusters.any?
          ul do
            team.clusters.each do |cluster|
              li link_to cluster, cluster_path(cluster)
            end
          end
        else
          "Esta equipe não está em nenhum cluster"
        end
      end
      row :axis
      row "Eventos" do |team|
        ul do
          team.events.each do |event|
            li link_to event.title, event_path(event)
          end
        end
      end

      active_admin_comments
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :link_miro
      f.input :link_teams
      f.input :axis
      f.input :clusters, as: :select, input_html: { multiple: true }, collection: Cluster.all
      f.input :members, as: :select, input_html: { multiple: true }, collection: Member.all
    end

    f.actions
  end
end
