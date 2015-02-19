#
# Create an initial user
#
User.create!(:email_address => 'admin@example.com', :password => 'password', :name => 'Admin User')

#
# Create a default site
#
Site.create!(:title => 'Viaduct Hosting', :description => 'Viaduct is a revolutionary hosting platform. This is our status site. Contact us at team@viaduct with any questions or problems.', :domain => 'staytus.dev', :support_email => 'team@viaduct.io', :website_url => 'http://viaduct.io')

#
# Add services
#
services                   = {}
services[:hosted_apps]    = Service.create!(:name => 'Hosted Applications')
services[:management_ui]  = Service.create!(:name => 'Management Interface')
services[:dns]            = Service.create!(:name => 'DNS')
services[:helpdesk]       = Service.create!(:name => 'Helpdesk')
services[:website]        = Service.create!(:name => 'Website & Documentation')
services[:webpush]        = Service.create!(:name => 'WebPush')

#
# Add locations
#
locations                 = {}
locations[:worldwide]     = Location.create!(:name => 'Worldwide')
locations[:eu_west_1]     = Location.create!(:name => 'EU West #1', :has_physical_presence => true, :physical_address => 'London, United Kingdom')
locations[:eu_west_2]     = Location.create!(:name => 'EU West #2', :has_physical_presence => true, :physical_address => 'Manchester, United Kingdom')
locations[:us_east_1]     = Location.create!(:name => 'US East #1', :has_physical_presence => true, :physical_address => 'New York, New York')

#
# Add services to physical locations
#
locations[:worldwide].services = [ services[:management_ui], services[:dns], services[:helpdesk], services[:website] ]
locations[:eu_west_1].services = [ services[:hosted_apps], services[:webpush] ]
locations[:eu_west_2].services = [ services[:hosted_apps], services[:webpush] ]
locations[:us_east_1].services = [ services[:hosted_apps], services[:webpush] ]
