class CreateWebhooks < ActiveRecord::Migration[5.1]
  def self.up
    create_table :webhooks do |table|
      table.string :name,                 null: false # Name of the Webhook
      table.string :url,                  null: false # URL of the Webhook
    end
  end

  def self.down
    drop_table :webhooks
  end
end
