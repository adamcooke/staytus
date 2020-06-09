namespace :heroku do
  desc 'Release Phase Task'
  #  This is tricky because this script runs every time Heroku deploys,
  #    including on the production app, staging app, and any review apps as well.
  task release: :environment do
    #First if checks if a database already exists.  If it does, it means the app is already setup.
    #In this case, just migrate the database.
    if ActiveRecord::Base.connection.data_source_exists?('schema_migrations')
      Rake::Task['db:migrate'].invoke
    else
      #If a database doesn't exist, this app is being deployed for the first time.
      #In this case, load the existing Schema.
      #If the Review App flag is present, seed the database.
      Rake::Task['db:schema:load'].invoke

      if ENV['REVIEW_APP_FLAG'].present?
        Rake::Task['db:seed'].invoke
      end
    end
  end
end
