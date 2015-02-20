class AddUserIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :user_id, :integer
  end
end
