require_relative "boot"

# require "rails/all"
require "rails"

unloaded = %w(
  action_mailer/railtie
  action_mailbox/engine
  action_text/engine
  active_job/railtie
  action_cable/engine
)

%w(
  active_storage/engine
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  rails/test_unit/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Thinktank
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
