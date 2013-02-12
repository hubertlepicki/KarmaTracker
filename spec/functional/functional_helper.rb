ENV['RAILS_ENV'] = 'test'
require_relative '../../config/environment.rb'

require 'database_cleaner'

#DatabaseCleaner.strategy = :deletion

module BaconHelpers
  def setup
    #DatabaseCleaner.clean
    #ActionMailer::Base.deliveries = []
  end
end

Bacon::Context.send(:include, BaconHelpers)

