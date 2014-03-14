require 'raven'

Raven.configure do |config|
  config.environments = %w[ production ]
  config.dsn = "https://#{Figaro.env.sentry_key_1}:#{Figaro.env.sentry_key_2}@app.getsentry.com/20433"
end