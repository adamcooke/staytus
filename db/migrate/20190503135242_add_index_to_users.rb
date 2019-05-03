class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :current_group_id
    add_index :users, :user_id
  end
end
