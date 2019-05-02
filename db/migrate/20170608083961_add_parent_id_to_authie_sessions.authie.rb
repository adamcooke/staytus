# This migration comes from authie (originally 20150109144120)
class AddParentIdToAuthieSessions < ActiveRecord::Migration[4.2]
  def change
    add_column :authie_sessions, :parent_id, :integer
  end
end
