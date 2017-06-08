# This migration comes from authie (originally 20170421174100)
class AddIndexToTokenHashesOnAuthieSessions < ActiveRecord::Migration[4.2]
  def change
    add_index :authie_sessions, :token_hash
  end
end
