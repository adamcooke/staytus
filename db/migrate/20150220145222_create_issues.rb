class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title, :state
      t.integer :service_status_id
      t.boolean :all_services, :default => true
      t.timestamps null: false
    end
  end
end
