class CreateIssueUpdates < ActiveRecord::Migration
  def change
    create_table :issue_updates do |t|
      t.integer :issue_id, :user_id, :service_status_id
      t.string :state
      t.text :text
      t.timestamps null: false
    end
  end
end
