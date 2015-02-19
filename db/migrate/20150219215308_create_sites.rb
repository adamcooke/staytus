class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :title, :description, :domain, :support_email, :website_url
    end
  end
end
