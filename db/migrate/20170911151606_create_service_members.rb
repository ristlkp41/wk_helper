class CreateServiceMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :service_members do |t|
      t.string :rank
      t.string :lastname
      t.string :firstname
      t.string :ahv_number

      t.timestamps
    end
  end
end
