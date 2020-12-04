class CreateSubscriberServiceJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriber_service_joins do |t|
      t.integer :subscriber_id, :service_id
      t.timestamps null: false
    end
  end
end
