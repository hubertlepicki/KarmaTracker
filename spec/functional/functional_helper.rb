ENV['RAILS_ENV'] = 'test'
require_relative '../../config/environment.rb'

require 'database_cleaner'
require_relative '../support/factories'

DatabaseCleaner.strategy = :truncation

module BaconHelpers
  def setup
    DatabaseCleaner.clean
    #ActionMailer::Base.deliveries = []
  end
end

Bacon::Context.send(:include, BaconHelpers)

