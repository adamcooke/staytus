ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    ServiceStatus.create_defaults
  end

  def json_response
    JSON.parse response.body, symbolize_names: true
  end
end

module StaytusTestExtensions

  def staytus_auth_headers
    token = api_tokens :one
    {
      'X-Auth-Token'  => token.token,
      'X-Auth-Secret' => token.secret
    }
  end

  %w[ get post put patch delete ].each do |m|
    define_method m do |path, params = {}, headers = {}|
      super path, params, staytus_auth_headers.merge(headers)
    end

    define_method "#{m}_json" do |path, params = {}, headers = {}|
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }.merge headers
      send m.to_sym, path, params.to_json, staytus_auth_headers.merge(headers)
    end
  end

end

ActionDispatch::IntegrationTest.send :include, StaytusTestExtensions
