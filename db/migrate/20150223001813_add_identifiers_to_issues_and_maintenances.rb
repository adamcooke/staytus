class AddIdentifiersToIssuesAndMaintenances < ActiveRecord::Migration[4.2]
  def change
    add_column :issues, :identifier, :string
    add_column :issue_updates, :identifier, :string
    add_column :maintenances, :identifier, :string
    add_column :maintenance_updates, :identifier, :string
  end
end
