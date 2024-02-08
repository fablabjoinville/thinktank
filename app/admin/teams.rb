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
      link_to "Miro: #{team.name}", team.link_miro if team.link_miro.present?
    end
    column "Sala Teams" do |team|
      link_to "Sala Teams: #{team.name}", team.link_teams if team.link_teams.present?
    end
    column "Clusters" do |team|
      link_to team.clusters.count, clusters_path(q: { id_in: team.cluster_ids })
    end
    column "Membros" do |team|
      link_to team.members.count, members_path(q: { team_id_eq: team.id })
    end
    column "Eventos" do |team|
      link_to team.events.count, events_path(q: { team_id_eq: team.id })
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

    columns do
      column do
        panel "Membros #{team.members.count}" do
          table_for team.members.joins(:person).order('role ASC').order('person.full_name ASC') do
            column :full_name, sortable: "person.full_name" do |member|
              link_to member.full_name, member_path(member)
            end

            tag_column :role
            column :active
            column "Presenças" do |member|
              member.attendances_counts
            end
            column "Ações" do |member|
              link_to "Remover", delete_and_redirect_back_member_path(member), method: :delete, data: { confirm: "Tem certeza que deseja remover?" }
            end
          end
        end
      end
      column do
        panel "Eventos #{team.events.count}" do
          table_for team.events do
            column :name do |event|
              link_to event.name, event_path(event)
            end
            column :date
            column :meeting
            column "Presenças" do |event|
              event.attendances_counts
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
      f.input :person_ids, collection: Person.ordered_by_full_name, as: :tags, display_name: :to_s, hint: "Selecione os membros da equipe. Todos serão adicionados como solucionadores."
    end

    f.actions
  end
end
