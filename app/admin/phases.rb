ActiveAdmin.register Phase do
  menu parent: "Encontros", priority: 4

  permit_params :id, :name, :_destroy, tool_ids: []

  index do
    selectable_column
    id_column

    column :name
    column "Encontros" do |phase|
      if phase.meetings.any?
        label = phase.meetings.count == 1 ? "Encontro" : "Encontros"
        link_to "#{phase.meetings.count} #{label}", meetings_path(q: { id_in: phase.meetings.ids })
      end
    end
    column "Ferramentas" do |phase|
      if phase.tools.any?
        label = phase.tools.count == 1 ? "Ferramenta" : "Ferramentas"
        link_to "#{phase.tools.count} #{label}", tools_path(q: { id_in: phase.tools.ids })
      end
    end

    actions
  end

  filter :name_cont, label: "Nome"
  filter :meetings, as: :select, label: "Encontros"
  filter :tools, as: :select, label: "Ferramentas"

  show do
    panel "Detalhes" do
      attributes_table_for phase do
        row :name
        row :meetings do |phase|
          if phase.meetings.any?
            ul do
              phase.meetings.each do |meeting|
                li link_to meeting.title, meeting_path(meeting)
              end
            end
          end
        end
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
