namespace :staytus do
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
