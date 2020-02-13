# frozen_string_literal: true

require 'spec_helper'
require 'shoulda/matchers'
require 'rspec/rails'
require 'factory_bot'
require 'database_cleaner'
require 'faker'
require 'simplecov'
SimpleCov.start.to_json

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].sort.each { |f| require f }
Dir[File.dirname(__FILE__) + '/helpers/**/*.rb'].sort.each { |f| require f }
Dir[File.dirname(__FILE__) + '/spec/helpers/**/*.rb'].sort.each { |f| require f }
Dir[File.dirname(__FILE__) + '/spec/support/**/*.rb'].sort.each { |f| require f }

abort('The Rails environment production mode!') if Rails.env.production?
abort('The Rails environment development mode!') if Rails.env.development?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include JsonAPIHelper, type: :request # only in request test types
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
