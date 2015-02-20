class CreateIssueServiceJoins < ActiveRecord::Migration
  def change
    create_table :issue_service_joins do |t|
      t.integer :issue_id, :service_id
      t.timestamps null: false
    end
  end
end
