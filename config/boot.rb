ENV['RAILS_ENV'] ||= 'production'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
$stdout.sync = true
$stderr.sync = true
require 'bundler/setup'
