class AddIsZukoAndIsAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_zuko, :boolean
    add_column :users, :is_admin, :boolean
  end
end
