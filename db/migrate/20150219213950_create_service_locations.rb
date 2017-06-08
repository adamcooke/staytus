class CreateServiceLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :service_locations do |t|
      t.integer :service_id, :location_id
      t.timestamps null: false
    end
  end
end
