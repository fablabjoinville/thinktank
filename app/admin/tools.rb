ActiveAdmin.register Tool do
  menu parent: "Administração", priority: 6
  config.sort_order = 'name_asc'

  permit_params(
    :_destroy,
    :id,
    :name,
    phase_ids: []
  )

  index do
    selectable_column

    column :name do |tool|
      link_to tool.name, tool_path(tool)
    end

    column "Fases" do |tool|
      if tool.phases.any?
        label = tool.phases.count == 1 ? "Fase" : "Fases"
        link_to "#{tool.phases.count} #{label}", phases_path(q: { id_in: tool.phases.ids })
      end
    end

    actions
  end

  filter :name_cont, label: "Nome"
  filter :phases, as: :select, label: "Fases"

  show do
    attributes_table do
      row :name
      row :phases do |tool|
        if tool.phases.any?
          ul do
            tool.phases.ordered_by_name.each do |phase|
              li link_to phase.name, phase_path(phase)
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
      f.input :phases, as: :select, collection: Phase.ordered_by_name, label: "Fases"
    end

    f.actions
  end
end
