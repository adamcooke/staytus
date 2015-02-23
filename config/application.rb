require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Staytus
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.generators do |g|
      g.orm             :active_record
      g.test_framework  false
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end
    config.i18n.load_path += Dir[Rails.root.join('content', 'locales', '*.{rb,yml}').to_s]
    config.active_record.raise_in_transactional_callbacks = true
  end
end
