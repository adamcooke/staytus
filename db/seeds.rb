#
# Create an initial user
#
User.create!(:email_address => 'admin@example.com', :password => 'password', :name => 'Admin User')

#
# Create a default site
#
Site.create!(:title => 'Viaduct Hosting', :description => 'Viaduct is a revolutionary hosting platform. This is our status site. Contact us at team@viaduct with any questions or problems.', :domain => 'staytus.dev', :support_email => 'team@viaduct.io', :website_url => 'http://viaduct.io')

#
# Create default statuses
#
ServiceStatus.create_defaults

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
