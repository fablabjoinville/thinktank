Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN') { '' }
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.traces_sample_rate = 1.0
  config.send_default_pii = true
end
