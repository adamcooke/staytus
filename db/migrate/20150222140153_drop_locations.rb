class DropLocations < ActiveRecord::Migration[4.2]
  def change
    drop_table :locations
    drop_table :service_locations
  end
end
