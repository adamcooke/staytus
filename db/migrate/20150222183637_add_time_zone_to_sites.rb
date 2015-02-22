class AddTimeZoneToSites < ActiveRecord::Migration
  def change
    add_column :sites, :time_zone, :string
  end
end
