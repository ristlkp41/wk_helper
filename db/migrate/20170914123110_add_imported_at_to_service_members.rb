class AddImportedAtToServiceMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :service_members, :imported_at, :datetime
  end
end
