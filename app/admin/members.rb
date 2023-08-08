require 'active_admin/views/index_as_grouped_table'

ActiveAdmin.register Member do
  menu priority: 5

  permit_params(
    :_destroy,
    :active,
    :id,
    :person_id,
    :role,
    :team_id,
  )

  controller do
    def scoped_collection
      end_of_association_chain.includes([:person, :team])
    end
  end

  index as: :grouped_table, group_by_attribute: :team do
    selectable_column

    column :full_name, sortable: "person.full_name" do |member|
      link_to member.full_name, member_path(member)
    end

    column :team, sortable: "team.name"
    tag_column :role
    column :active

    actions
  end

  filter :person_full_name_cont, label: "Nome"
  filter :team, as: :select, collection: Team.all, label: "Equipe"
  filter :active, as: :select, collection: [["Ativo", true], ["Inativo", false]], label: "Ativo"
  filter :role, as: :select, label: "Role"
  filter :company_id_eq, as: :select, collection: Company.all, label: "Empresa"

  show do
    attributes_table do
      tag_row :role
      row :team
      row :active
    end

    panel "Pessoa" do
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
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :team, as: :select, collection: Team.all, input_html: { class: "default-select" }, prompt: "Selecione a equipe"
      f.input :person, as: :select, collection: Person.all, input_html: { class: "default-select" }, prompt: "Selecione a pessoa"

      f.input :role, as: :select, collection: Member.roles.keys.map { |k|
        [Member.humanized_enum_value(:role, k), k]
      }, input_html: { class: "default-select" }, prompt: "Selecione o role"
      f.input :active
    end

    f.actions
  end
end
