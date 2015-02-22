class CreateMaintenanceServiceJoins < ActiveRecord::Migration
  def change
    create_table :maintenance_service_joins do |t|
      t.integer :maintenance_id, :service_id
      t.timestamps null: false
    end
  end
end
