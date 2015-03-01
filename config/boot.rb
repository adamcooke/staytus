ENV['RAILS_ENV'] ||= 'production'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup'

# Set the default port for the application
require 'rails/commands/server'
module Rails
  class Server
    alias :original_default_options :default_options
    def default_options
      original_default_options.merge(
        :Port => ENV['PORT'] || 8787,
        :Host => '0.0.0.0'
      )
    end
  end
end
