namespace :staytus do
  desc 'Upgrade Stayus'
  task :upgrade => :environment do
    # Don't have anything to do here at the moment.
  end
end

Rake::Task['staytus:upgrade'].enhance ['db:migrate']
