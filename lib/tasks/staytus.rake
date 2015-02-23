namespace :staytus do

  task :protect_installation => :environment do
    site = Site.first rescue nil
    if site && ENV['I_AM_SURE'] != '1'
      puts "\e[31mYou already seem to have completed the setup for this installation."
      puts "If you wish to re-install, please re-run the command below.\e[0m"
      puts
      puts "    I_AM_SURE=1 bundle exec rake staytus:install"
      puts
      puts "\e[41;37mWarning: this will delete all the data from your database.\e[0m"
      exit 1
    end
  end

  desc 'Build Staytus from source'
  task :build => :environment do
    # Don't have anything to do here at the moment.
  end

  desc 'Install Staytus'
  task :install => :environment do
    # Don't have anything to do here at the moment.
  end

  desc 'Upgrade Stayus'
  task :upgrade => :environment do
    # Don't have anything to do here at the moment.
  end
end

Rake::Task['staytus:build'].enhance ['assets:clobber', 'assets:precompile']
Rake::Task['staytus:install'].enhance ['staytus:protect_installation', 'db:schema:load']
Rake::Task['staytus:upgrade'].enhance ['db:migrate']
