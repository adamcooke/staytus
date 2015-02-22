class StoreActualCloseTimeOnMaintenance < ActiveRecord::Migration
  def change
    remove_column :maintenances, :closed
    add_column :maintenances, :closed_at, :datetime
  end
end
