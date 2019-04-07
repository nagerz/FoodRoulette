# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

require 'vcr'
require 'webmock/rspec'
require 'support/factory_bot.rb'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<GOOGLE_CLIENT_ID>') { ENV['GOOGLE_CLIENT_ID'] }
  config.filter_sensitive_data('<GOOGLE_CLIENT_SECRET>') { ENV['GOOGLE_CLIENT_SECRET'] }
  config.filter_sensitive_data('<YELP_API_KEY>') { ENV['YELP_API_KEY'] }
end

OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
  provider: "google",
  uid: "108693550823420995807",
  info: {
    email: "marcootj@gmail.com",
    first_name: "Julia",
    last_name: "Marco",
    image: "https://lh6.googleusercontent.com/-v5E7X9BssFY/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rc9ovNgz_Eslf59KrWqo3Oi7jQLMQ/mo/photo.jpg"
  },
  credentials: {
    token: ENV['TOKEN'],
    refresh_token: ENV['REFRESH_TOKEN'],
    expires_at: 1554258409
  }
})

def stub_get_json(url, filename)
  json_response = File.open("./spec/fixtures/#{filename}")

  stub_request(:get, url)
    .to_return(status: 200, body: json_response)
end

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end


  Capybara.configure do |config|
    config.default_max_wait_time = 5
  end

  SimpleCov.start 'rails'

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.include FactoryBot::Syntax::Methods

    config.use_transactional_fixtures = true

    config.infer_spec_type_from_file_location!

    config.filter_rails_from_backtrace!

    Capybara.server_port = 3001
    Ngrok::Rspec.tunnel = { port: Capybara.server_port }
    
    config.include Ngrok::Rspec
  end
