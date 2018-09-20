Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.require_master_key = true
  config.public_file_server.enabled = true
  config.force_ssl = true
  config.active_record.dump_schema_after_migration = false
  config.log_formatter = ::Logger::Formatter.new
  logger = ActiveSupport::Logger.new(STDOUT)
  logger.formatter = config.log_formatter
  config.logger = ActiveSupport::TaggedLogging.new(logger)
end
