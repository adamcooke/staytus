class AddExtraFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :icon,             :string
    add_column :users, :user_id,          :string
    add_column :users, :last_log_on,      :datetime
    add_column :users, :last_log_off,     :datetime
    add_column :users, :current_group_id, :bigint
    add_column :users, :first_name,       :string
    add_column :users, :last_name,        :string
  end
end
