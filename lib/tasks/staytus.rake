namespace :staytus do

  desc 'Install Staytus'
  task :install => :environment do
    # Don't have anything to do here at the moment.
  end
  desc 'Upgrade Stayus'
  task :upgrade => :environment do
    # Don't have anything to do here at the moment.
  end
end

Rake::Task['staytus:install'].enhance ['db:schema:load']
Rake::Task['staytus:upgrade'].enhance ['db:migrate']
