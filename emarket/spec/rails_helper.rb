# spec/rails_helper.rb
require 'faker'


require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'factory_bot_rails'    # <-- Require FactoryBot subito dopo RSpec
require 'capybara/rspec'
require 'database_cleaner-active_record'


begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # FactoryBot: usa la sintassi diretta (create, build, etc.) senza FactoryBot. prefisso
  config.include FactoryBot::Syntax::Methods

  # Configurazione fixture path (se usi fixture)
  config.fixture_path = Rails.root.join('spec/fixtures')

  # Usa transazioni per pulire il DB fra i test
  config.use_transactional_fixtures = true

  # Capybara con rack_test driver di default per test di sistema
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  # Configurazione DatabaseCleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Inferenzia il tipo di spec da path file
  config.infer_spec_type_from_file_location!

  # Filtra le gem di Rails negli errori
  config.filter_rails_from_backtrace!

  # Altre configurazioni (se vuoi aggiungere)
  # config.filter_gems_from_backtrace("gem name")
end
