class AddUserIdToIssues < ActiveRecord::Migration[4.2]
  def change
    add_column :issues, :user_id, :integer
  end
end
