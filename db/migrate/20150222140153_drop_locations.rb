class DropLocations < ActiveRecord::Migration
  def change
    drop_table :locations
    drop_table :service_locations
  end
end
