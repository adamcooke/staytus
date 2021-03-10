require 'clockwork'
require_relative 'environment'

module Clockwork

  configure do |config|
    config[:tz] = 'UTC'
  end

  every 1.hour, 'hourly', :at => '**:00' do
    Maintenance.close_finished
  end

end
