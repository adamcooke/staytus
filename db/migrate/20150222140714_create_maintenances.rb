class CreateMaintenances < ActiveRecord::Migration
  def change
    create_table :maintenances do |t|
      t.string :title
      t.text :description
      t.datetime :start_at, :finish_at
      t.integer :length_in_minutes
      t.boolean :closed, :default => false
      t.integer :user_id, :service_status_id
      t.timestamps null: false
    end
  end
end
