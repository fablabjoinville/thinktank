ActiveAdmin.register Phase do
  menu parent: "Administração", priority: 4

  permit_params(
    :_destroy,
    :id,
    :name,
    tool_ids: []
  )

  index do
    selectable_column
    id_column

    column :name
    column "Ferramentas" do |phase|
      if phase.tools.any?
        label = phase.tools.count == 1 ? "Ferramenta" : "Ferramentas"
        link_to "#{phase.tools.count} #{label}", tools_path(q: { id_in: phase.tools.ids })
      end
    end

    actions
  end

  filter :name_cont, label: "Nome"
  filter :tools, as: :select, label: "Ferramentas"

  show do
    attributes_table do
      row :name
      row :tools do |phase|
        if phase.tools.any?
          ul do
            phase.tools.each do |tool|
              li link_to tool.name, tool_path(tool)
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
      f.input :tools, as: :select, collection: Tool.all, label: "Ferramentas"
    end

    f.actions
  end
end
