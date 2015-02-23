class AddIdentifiersToIssuesAndMaintenances < ActiveRecord::Migration
  def change
    add_column :issues, :identifier, :string
    add_column :issue_updates, :identifier, :string
    add_column :maintenances, :identifier, :string
    add_column :maintenance_updates, :identifier, :string
  end
end
