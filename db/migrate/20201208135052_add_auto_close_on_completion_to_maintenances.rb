class AddAutoCloseOnCompletionToMaintenances < ActiveRecord::Migration[5.2]

  def change
    add_column :maintenances, :auto_close_on_completion, :boolean, default: false
  end

end
