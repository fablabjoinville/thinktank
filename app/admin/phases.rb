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
            phase.tools.ordered_by_name.each do |tool|
              li link_to tool.name, tool_path(tool)
            end
          end
        end
      end
    end

    panel "Ferramentas: #{phase.tools.count}" do
      table_for phase.tools.ordered_by_name do
        column :name do |tool|
          link_to tool.name, tool_path(tool)
        end
      end
    end

    panel "Encontros: #{phase.meetings.count}" do
      table_for phase.meetings.ordered_by_name do
        column :name do |meeting|
          link_to meeting.name, meeting_path(meeting)
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :tools, as: :select, collection: Tool.ordered_by_name, label: "Ferramentas"
    end

    f.actions
  end
end
