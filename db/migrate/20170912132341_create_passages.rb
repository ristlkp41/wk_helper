class CreatePassages < ActiveRecord::Migration[5.1]
  def change
    create_table :passages do |t|
      t.references :service_member, index: true, foreign_key: true
      t.datetime :passed_at, null: false
      t.string :way, null: false
    end
  end
end
