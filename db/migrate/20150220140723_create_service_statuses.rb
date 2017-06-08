class CreateServiceStatuses < ActiveRecord::Migration[4.2]
  def change
    create_table :service_statuses do |t|
      t.string :name, :permalink, :color, :status_type
      t.timestamps null: false
    end
    add_column :services, :status_id, :integer
  end
end
