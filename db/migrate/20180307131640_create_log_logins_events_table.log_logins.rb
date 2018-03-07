# This migration comes from log_logins (originally 20180307100300)
class CreateLogLoginsEventsTable < ActiveRecord::Migration[4.2]

  def change
    create_table :login_events do |t|
      t.string :user_type   # User, APIToken
      t.integer :user_id    # 141

      t.string :username

      t.string :action      # Success, Failed, Blocked
      t.string :interface    # Web, API, SomeOtherInterface
      t.string :ip          # 1.2.3.4
      t.string :user_agent

      t.datetime :created_at

      t.index [:user_type, :user_id], :length => {:user_type => 10}
      t.index :ip, :length => 10
      t.index :interface, :length => 10
      t.index :created_at
    end
  end

end
