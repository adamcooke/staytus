ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
$stderr.sync = true
require 'bundler/setup'
