ActiveAdmin.register Team do
  menu parent: "Equipes", priority: 0

  permit_params :name, :link_miro, :link_teams, :axis_id, member_ids: [], cluster_ids: []

  index do
    selectable_column

    column :name do |team|
      link_to team.name, team_path(team)
    end
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

  filter :name_cont, label: "Nome"
  filter :clusters, as: :select, label: "Clusters"
  filter :members, as: :select, label: "Membros"
  filter :axis, as: :select, label: "Eixo"

  show do
    attributes_table do
      row :name
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
              li link_to member.full_name, member_path(member)
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
      row :axis
      row "Encontros" do |team|
        if team.meetings.any?
          ul do
            team.meetings.each do |meeting|
              li link_to meeting.title, meeting_path(meeting)
            end
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
      f.input :axis, input_html: { class: "slim-select" }, prompt: "Selecione o eixo"
      f.input :clusters, collection: Cluster.all, as: :tags, display_name: :to_s, hint: "Selecione os clusters"
      f.input :member_ids, collection: Member.all, as: :tags, display_name: :to_s, hint: "Selecione os membros da equipe"
    end

    f.actions
  end
end
