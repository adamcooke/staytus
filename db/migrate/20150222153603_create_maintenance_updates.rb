class CreateMaintenanceUpdates < ActiveRecord::Migration[4.2]
  def change
    create_table :maintenance_updates do |t|
      t.integer :maintenance_id, :user_id
      t.text :text
      t.timestamps null: false
    end
  end
end
