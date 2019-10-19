require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "rails/test_unit/railtie"
require "active_storage/engine"
require "active_job/railtie"

Bundler.require(*Rails.groups)

module Pylon
  class Application < Rails::Application
    # In order for Graphiti to generate links, you need to set the routes host.
    # When not explicitly set, via the HOST env var, this will fall back to
    # the rails server settings.
    # Rails::Server is not defined in console or rake tasks, so this will only
    # use those defaults when they are available.
    routes.default_url_options[:host] = ENV.fetch('HOST') do
      if defined?(Rails::Server)
        argv_options = Rails::Server::Options.new.parse!(ARGV)
        "http://#{argv_options[:Host]}:#{argv_options[:Port]}"
      end
    end
    config.load_defaults 6.0
    config.api_only = true

    config.session_store :cookie_store, key: Rails.application.secrets.secret_key_base
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, Rails.application.config.session_options
  end
end
