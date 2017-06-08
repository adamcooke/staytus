class AddDescriptionToServices < ActiveRecord::Migration[4.2]
  def change
    add_column :services, :description, :text
  end
end
