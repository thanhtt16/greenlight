# frozen_string_literal: true

class AddCanManageCompaniesToRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :can_manage_companies, :boolean, after: :can_manage_users, default: false
    RolePermission.create(
      [
        { name: "can_manage_companies", value: "true", enabled: true, role_id: 2 },
        { name: "can_manage_companies", value: "true", enabled: true, role_id: 5 },
      ]
    )
  end
end
