require 'pry'
require 'rspec'
require 'capybara/rspec'
require "database_cleaner"

require_relative '../app.rb'

set :environment, :test

Capybara.app = Sinatra::Application

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

end
