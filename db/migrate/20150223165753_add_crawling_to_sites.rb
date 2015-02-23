class AddCrawlingToSites < ActiveRecord::Migration
  def change
    add_column :sites, :crawling_permitted, :boolean, :default => false
  end
end
