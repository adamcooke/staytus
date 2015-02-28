class AddEmailSettingsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :email_from_name, :string
    add_column :sites, :email_from_address, :string
  end
end
