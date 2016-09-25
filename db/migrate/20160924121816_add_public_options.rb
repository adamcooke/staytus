class AddPublicOptions < ActiveRecord::Migration
  def change
    add_column :sites, :title_public, :string
    add_column :sites, :domain_public, :string
    add_column :services, :is_public, :boolean, :default => false
  end
end
