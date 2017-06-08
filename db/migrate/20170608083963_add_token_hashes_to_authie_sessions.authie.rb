# This migration comes from authie (originally 20170417170000)
class AddTokenHashesToAuthieSessions < ActiveRecord::Migration[4.2]
  def change
    add_column :authie_sessions, :token_hash, :string
  end
end
