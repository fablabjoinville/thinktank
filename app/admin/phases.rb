ActiveAdmin.register Phase do
  menu parent: "Encontros", priority: 4

  permit_params :id, :name, :_destroy

  index do
    selectable_column
    id_column

    column :name
    column "Encontros" do |phase|
      if phase.meetings.any?
        label = phase.meetings.count == 1 ? "Encontro" : "Encontros"
        link_to "#{phase.meetings.count} #{label}", meetings_path(q: { phase_id_eq: phase.id })
      end
    end

    actions
  end

  filter :name_cont, label: "Nome"

  show do
    panel "Detalhes" do
      attributes_table_for phase do
        row :name
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
    end

    f.actions
  end
end
