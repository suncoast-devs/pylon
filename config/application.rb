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
    config.load_defaults 5.2
    config.api_only = true

    config.session_store :cookie_store, key: Rails.application.secrets.secret_key_base
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, Rails.application.config.session_options
  end
end
