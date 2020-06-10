
source 'https://rubygems.org'
ruby '2.5.7'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1'
gem 'mysql2'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'haml'
gem 'nifty-utils'
gem 'nilify_blanks'
gem 'authie'
gem 'kaminari'
gem 'chronic'
gem 'dynamic_form'
gem 'activevalidators'
gem 'bcrypt'
gem 'rails_env_config'
gem 'chronic_duration'
gem 'datey'
gem 'nifty-attachments'
gem 'puma'
gem 'moonrope'
gem 'florrick'
gem 'delayed_job_active_record'
gem 'foreman'
gem 'redcarpet'
gem 'premailer'
gem 'rack-custom-proxies'
gem 'log_logins'

group :development, :test do
  gem 'dotenv-rails'
  gem 'annotate', '~> 2.6.5'
  gem 'awesome_print' # adds style to pry print out- we can remove this one if its too different for anyone
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'heroku_ops'
  gem 'heroku_rake_deploy', github: 'ldstudios/heroku_rake_deploy'
  gem 'letter_opener' #Opens delivered email in a Browser tab!
  gem 'pry-byebug' # adds step, next, finish, continue, and breakpoint commands to pry
  gem 'pry-rails' # Debugging
  gem 'pry-rescue' # run your server with rescue to open pry on any error 'bundle exec rescue rails s'
  gem 'pry-stack_explorer' #adds up, down, frame, and show-stack to pry commands
end


group :production do
  #gem 'newrelic_rpm'
  gem 'rails_12factor' #required by Heroku
end

# group :test do
#   gem 'capybara'
#   gem 'selenium-webdriver'
#   gem 'webdrivers', '~> 3.0'
#   gem 'database_cleaner'
#   gem 'fakeredis', :require => 'fakeredis/rspec'
#   gem 'rails-controller-testing'
#   gem 'rspec-collection_matchers'
#   gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
#   gem 'rspec-sidekiq'
#   #gem 'rspec-retry'
#   gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
#   gem 'simplecov', :require => false
#   gem 'site_prism'
#   gem 'vcr', '~> 3.0', '>= 3.0.3'
#   gem 'webmock', '~> 3.0', '>= 3.0.1'
#   #gem 'wisper-rspec'
#   gem 'launchy'
#   gem 'timecop'
# end

group :development do
#   gem 'listen', '>= 3.0.5', '< 3.2'
#   # gem 'spring'
#   # gem 'spring-watcher-listen', '~> 2.0.0'
#   gem 'web-console', '>= 3.3.0'
#   gem 'papertrail' #Papertrail CLI gem, allows log searching without having to open up Heroku and navigate to their web interface!
    gem 'lol_dba'
end

