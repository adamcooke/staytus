#
# Create an initial user
#
User.create!(:email_address => 'admin@example.com', :password => 'password', :name => 'Admin User')

#
# Create a development API token
#
ApiToken.create!(:name => "Demo Token", :token => 'demo', :secret => 'demo')

#
# Create a default site
#
Site.create!(:title => 'The Widgets Status Site', :description => 'Widgets Inc is a revolutionary widget platform. This is our status site. Contact us at team@widgetsrus.io with any questions or problems.', :domain => Rails.env.production? ? 'demo.staytus.co' : 'localhost:8787', :support_email => 'team@viaduct.io', :website_url => 'http://staytus.co', :time_zone => 'London')

#
# Create default statuses
#
ServiceStatus.create_defaults

#
# Add services
#
services                 = {}
services[:app]           = Service.create!(:name => 'Web Application', :description => "The web interface to the widget making application.")
services[:api]           = Service.create!(:name => 'Developer API', :description => "Our HTTP JSON API for application developers.")
services[:factory]       = Service.create!(:name => 'Widget Factory', :description => "Where the magic happens.")
services[:website]       = Service.create!(:name => 'Website & Documentation', :description => "Our own website and application documentation.")
services[:helpdesk]      = Service.create!(:name => 'Helpdesk')

#
# Add some example issues
#
issue = Issue.new
issue.created_at = Time.new(2015, 1, 2, 11, 38)
issue.title = 'Hobby/Dev Database Issues'
issue.initial_update = 'We are aware of issues with database01 which hosts some Hobby/Dev level databases.'
issue.state = 'investigating'
issue.service_status = ServiceStatus.find_by_name('Partial Outage')
issue.user = User.first
issue.services = [services[:app]]
issue.save!

update = issue.updates.build
update.text = "The host in question became unresponsive and was rebooted. It is now back online and we will continue to monitor the situation."
update.state = 'monitoring'
update.service_status = ServiceStatus.find_by_name('Operational')
update.user = User.first
update.created_at = Time.new(2015, 1, 2, 11, 40)
update.save!

update = issue.updates.build
update.text = "The issue appears to have re-occurred. We are investigating again."
update.state = 'investigating'
update.service_status = ServiceStatus.find_by_name('Partial Outage')
update.user = User.first
update.created_at = Time.new(2015, 1, 2, 11, 55)
update.save!

update = issue.updates.build
update.text = "The host become unresponsive again and has been rebooted. We are currently formulating a plan to take the host out of service for further investigating while maintaining access the data & databases stored on it. We recommend users take their own exports of their databases."
update.state = 'monitoring'
update.service_status = ServiceStatus.find_by_name('Operational')
update.user = User.first
update.created_at = Time.new(2015, 1, 2, 12, 27)
update.save!

update = issue.updates.build
update.text = "We have now migrated all databases & data which were on the affected database host to another machine. This is only a temporary measure and we will need to perform a full migration in due course. To do this, we will need to restart any affected applications. We will post information about this separated as scheduled maintenance."
update.state = 'resolved'
update.user = User.first
update.created_at = Time.new(2015, 1, 2, 22, 05)
update.save!

issue = Issue.new
issue.created_at = Time.new(2014, 12, 9, 5, 21)
issue.title = 'Network Connectivity Issues'
issue.initial_update = "We're currently working with resolving a network issue which is affecting access to the Viaduct EU-West-1 network."
issue.state = 'investigating'
issue.service_status = ServiceStatus.find_by_name('Partial Outage')
issue.user = User.first
issue.services = [services[:app], services[:factory]]
issue.save!

update = issue.updates.build
update.text = "This issue has now been resolved."
update.state = 'resolved'
update.service_status = ServiceStatus.find_by_name('Operational')
update.user = User.first
update.created_at = Time.new(2014, 12, 9, 5, 32)
update.save!

issue = Issue.new
issue.created_at = 25.minutes.ago
issue.title = 'Network Connectivity Issues'
issue.initial_update = "We're currently working with resolving a network issue which is affecting access to the Viaduct EU-West-1 network."
issue.state = 'investigating'
issue.service_status = ServiceStatus.find_by_name('Partial Outage')
issue.user = User.first
issue.services = [services[:app], services[:api], services[:factory], services[:website]]
issue.save!

update = issue.updates.build
update.text = "We've identified the issue and working to adjust our routing to route around the issue with an upstream provider."
update.state = 'identified'
update.user = User.first
update.created_at = 20.minutes.ago
update.save!

update = issue.updates.build
update.text = "We've adjusted some of our routing policies and hope this has resolved issue globally. We will continue to monitor the situation and update this issue if problems continue."
update.state = 'monitoring'
update.user = User.first
issue.service_status = ServiceStatus.find_by_name('Operational')
update.created_at = 15.minutes.ago
update.save!

update = issue.updates.build
update.text = "It appears that the changes we made earlier weren't properly propogated to all routers on our network. We're pushing a fix out not."
update.state = 'identified'
update.user = User.first
issue.service_status = ServiceStatus.find_by_name('Partial Outage')
update.created_at = 13.minutes.ago
update.save!

update = issue.updates.build
update.text = "Right. We think everything is now resolved. We're monitoring the situation again but not expecting any further issues."
update.state = 'monitoring'
update.user = User.first
issue.service_status = ServiceStatus.find_by_name('Operational')
update.created_at = 5.minutes.ago
update.save!

#
# Add some maintenance
#
maintenance = Maintenance.new
maintenance.created_at = Time.new(2014, 11, 25, 6, 52)
maintenance.start_at = Time.new(2014, 12, 1, 21)
maintenance.length_in_minutes = 60
maintenance.title = "Routine Storage Maintenance"
maintenance.description = "We'll be performing some routine maintenance on our platform this evening which will result in the management UI being unavailable. This is the final phase of our work to move all our infrastructure over to our new storage infrastructure."
maintenance.services = [services[:api]]
maintenance.service_status = ServiceStatus.find_by_name('Maintenance')
maintenance.user = User.first
maintenance.closed_at = Time.new(2014, 12, 2, 0, 29)
maintenance.save!

update = maintenance.updates.build
update.created_at = Time.new(2014, 12, 1, 21, 02)
update.text = "This maintenance has now begun."
update.user = User.first
update.save!

update = maintenance.updates.build
update.created_at = Time.new(2014, 12, 2, 0, 29)
update.text = "This maintenance is now complete. Our old storage infrastructure will be removed from the datacentre later this week."
update.user = User.first
update.save!

maintenance = Maintenance.new
maintenance.created_at = 4.days.ago
maintenance.start_at = 5.minutes.ago
maintenance.length_in_minutes = 120
maintenance.title = "Software Upgrades"
maintenance.description = "We will be carrying out an upgrade of some of the software which powers our platform. We do not anticipate any downtime during this period however the service should be considered at risk for the duration."
maintenance.services = [services[:app]]
maintenance.service_status = ServiceStatus.find_by_name('Maintenance')
maintenance.user = User.first
maintenance.save!

services[:factory].status = ServiceStatus.find_by_name('Partial Outage')
services[:factory].save

services[:helpdesk].status = ServiceStatus.find_by_name('Major Outage')
services[:helpdesk].save
