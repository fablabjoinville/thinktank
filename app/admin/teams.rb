ActiveAdmin.register Team do
  menu priority: 4
  config.create_another = true
  config.sort_order = 'name_asc'

  permit_params(
    :_destroy,
    :axis_id,
    :cluster_id,
    :id,
    :link_miro,
    :link_teams,
    :name,
    user_ids: []
  )

  scope -> { Chapter.latest_year.to_s }, :latest_year, default: true do |team|
    team.filtered_by_latest_year
  end
  scope "Todos", :all

  filter :name_cont, label: "Nome"
  filter :cluster, as: :select, label: "Cluster"
  filter :axis, as: :select, label: "Eixo"

  index download_links: false do
    selectable_column

    column :name do |team|
      link_to team.name, team_path(team)
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
    column "Cluster" do |team|
      if team.cluster
        link_to team.cluster.name, cluster_path(team.cluster)
      end
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

  show do
    attributes_table do
      row :name
      row :axis
      tag_row "Modalidade" do |team|
        team.modality || "Não definida"
      end
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
      row "Cluster" do |team|
        if team.cluster
          link_to team.cluster.name, cluster_path(team.cluster)
        end
      end
    end

    columns do
      column do
        panel "Membros: #{team.members.count}" do
          table_for team.members.joins(:user).order('role ASC').order('users.full_name ASC') do
            column :full_name, sortable: "users.full_name" do |member|
              link_to member.full_name, member_path(member)
            end
            tag_column :role
            column :active
            tag_column :modality
            column "Presenças" do |member|
              member.attendances_counts
            end
            if current_user.authorization_level.to_sym.in?([:admin, :superadmin])
              column "Ações" do |member|
                link_to("Remover", delete_and_redirect_back_member_path(member),
                  { method: :delete, data: { confirm: "Tem certeza que deseja remover?" } })
              end
            end
          end
        end
      end
      column do
        panel "Eventos: #{team.events.count} (#{link_to("adicionar", new_event_path(team_id: team.id))})".html_safe do
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
      f.input :cluster_id, as: :select, collection: Cluster.all, display_name: :to_s, input_html: { class: "slim-select" }, hint: "Selecione o cluster"
      f.input :user_ids, collection: User.ordered_by_full_name, as: :tags, display_name: :to_s, hint: "Selecione os membros da equipe. Todos serão adicionados como solucionadores."
    end

    f.actions
  end
end
