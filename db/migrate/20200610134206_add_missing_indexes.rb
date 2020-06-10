
class AddMissingIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :authie_sessions, :parent_id
    add_index :authie_sessions, [:user_id, :user_type]
    add_index :history_items, [:item_id, :item_type]
    add_index :issue_service_joins, :issue_id
    add_index :issue_service_joins, :service_id
    add_index :issue_service_joins, [:issue_id, :service_id], unique: true
    add_index :issue_updates, :issue_id
    add_index :issue_updates, :service_status_id
    add_index :issue_updates, :user_id
    add_index :issues, :service_status_id
    add_index :issues, :user_id
    add_index :maintenance_service_joins, :maintenance_id
    add_index :maintenance_service_joins, :service_id
    add_index :maintenance_service_joins, [:maintenance_id, :service_id], unique: true
    add_index :maintenance_updates, :maintenance_id
    add_index :maintenance_updates, :user_id
    add_index :maintenances, :service_status_id
    add_index :maintenances, :user_id
    add_index :nifty_attachments, [:parent_id, :parent_type]
    add_index :services, :group_id
    add_index :services, :status_id
  end
end
