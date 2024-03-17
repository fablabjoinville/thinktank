ActiveAdmin.register Chapter do
  menu parent: "Administração", priority: 4

  permit_params(
    :_destroy,
    :edition_year,
    :id,
    :title,
    cluster_ids: []
  )

  index do
    selectable_column
    id_column

    column :title
    column :edition_year
    column :clusters do |chapter|
      if chapter.clusters.any?
        label = chapter.clusters.count == 1 ? "Cluster" : "Clusters"
        link_to "#{chapter.clusters.count} #{label}", clusters_path(q: { id_in: chapter.clusters.ids })
      end
    end

    actions
  end

  filter :title_cont, label: "Capítulo"
  filter :edition_year, as: :select, label: "Ano da edição"
  filter :clusters, as: :select, label: "Clusters"

  show do
    attributes_table do
      row :title
      row :edition_year
      row :clusters do |chapter|
        if chapter.clusters.any?
          ul do
            chapter.clusters.ordered_by_week_day.each do |cluster|
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
      f.input :title
      f.input :edition_year
    end

    f.actions
  end
end
