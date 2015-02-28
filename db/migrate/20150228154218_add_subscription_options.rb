class AddSubscriptionOptions < ActiveRecord::Migration
  def change
    add_column :issues, :notify, :boolean, :default => false
    add_column :issue_updates, :notify, :boolean, :default => false
    add_column :maintenances, :notify, :boolean, :default => false
    add_column :maintenance_updates, :notify, :boolean, :default => false
    add_column :sites, :allow_subscriptions, :boolean, :default => true
  end
end
