class AddHttpProtocolToSites < ActiveRecord::Migration
  def change
    add_column :sites, :http_protocol, :string
    Site.where(:http_protocol => nil).update_all(:http_protocol => 'http')
  end
end
