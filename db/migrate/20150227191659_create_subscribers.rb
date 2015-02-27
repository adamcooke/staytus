class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email_address, :verification_token
      t.datetime :verified_at
      t.timestamps null: false
    end
  end
end
