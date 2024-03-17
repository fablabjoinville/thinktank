require 'active_admin/views/index_as_grouped_table'

ActiveAdmin.register Member do
  menu priority: 5
  config.create_another = true
  config.sort_order = 'person.full_name_asc'

  includes :person, :team

  permit_params(
    :_destroy,
    :active,
    :id,
    :modality,
    :person_id,
    :role,
    :team_id,
  )

  action_item :new_model, only: :show do
    localizer = ActiveAdmin::Localizers.resource(active_admin_config)
     link_to localizer.t(:new_model), new_resource_path
  end

  member_action :delete_and_redirect_back, method: :delete do
    member = Member.find(params[:id])
    member.destroy!
    redirect_backwards_or_to_root
  end

  index as: :grouped_table, group_by_attribute: :team do
    selectable_column
    column :full_name, sortable: "person.full_name" do |member|
      link_to member.full_name, member_path(member)
    end
    column :team, sortable: "team.name"
    tag_column :role
    tag_column :modality
    column :active

    actions
  end

  filter :person_full_name_cont, label: "Nome"
  filter :team, as: :select, collection: -> { Team.ordered_by_name }, label: "Equipe"
  filter :active, as: :select, collection: [["Ativo", true], ["Inativo", false]], label: "Ativo"
  filter :role, as: :select, label: "Role"
  filter :company_id_eq, as: :select, collection: -> { Company.ordered_by_name }, label: "Empresa"

  show do
    columns do
      column do
        attributes_table do
          row :full_name
          row :team
          tag_row :role
          tag_row :modality
          row :active
        end

        panel "Dados cadastrais (#{link_to "editar", member.person })".html_safe do
          attributes_table_for member.person do
            row :full_name
            row :nickname
            row :email
            row :phone_number
            row :celular_number
            row :address
            row :cpf
            row :rg
            row :birthday
            row :company
            tag_row :gender
            row :image do |person|
              image_tag(person.avatar_path, { width: 200, height: "auto" })
            end
          end
        end
      end
      column do
        panel "Participações em eventos: #{member.attendances.count}" do
          table_for member.attendances do
            column :event
            column :date do |attendance|
              attendance.event.date
            end
            tag_column :status
            column :reason
            column "Ações" do |attendance|
              ul class: "actions" do
                li do
                  link_to "Presente", update_status_event_attendance_path(attendance.event, attendance, status: :present), method: :put
                end
                li do
                  link_to "Ausente", update_status_event_attendance_path(attendance.event, attendance, status: :absent ), method: :put
                end
                li do
                  link_to "Justificar", edit_event_attendance_path(attendance.event, attendance)
                end
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
      f.input :team, as: :select, collection: Team.ordered_by_name, input_html: { class: "slim-select" }, prompt: "Selecione a equipe"
      f.input :person, as: :select, collection: Person.ordered_by_full_name, input_html: { class: "slim-select" }, prompt: "Selecione a pessoa"
      f.input :role, as: :select, collection: Member.humanized_enum_list(:roles), input_html: { class: "default-select" }, prompt: "Selecione o role"
      f.input :modality, as: :radio, collection: Member.humanized_enum_list(:modalities)
      f.input :active
    end

    f.actions
  end
end
