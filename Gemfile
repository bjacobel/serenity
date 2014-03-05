source 'https://rubygems.org'

#############################
# Defaults and recommendeds #
#############################

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use debugger
gem 'debugger', group: [:development, :test]

# Use the unicorn server in production (use `rails s` in dev/test)
gem 'unicorn', group: :production

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#################
# Special sauce #
#################

# Use postgres as the database for Active Record
gem 'pg', '0.17.1'

# For Github authentication/authorization
gem 'warden-github-rails', '~> 1.1.0'

# Figaro makes environment variables less of a PITA
gem 'figaro'

# ERB is boring and HAML is slow
gem "slim-rails"

# Amazon Web Services SDK (for spinning up EC2 machines)
gem 'aws-sdk', '~> 1.0'

# Heroku extras and addons
gem 'rails_12factor', group: :production
gem 'newrelic_rpm', group: :production
gem "mailgun"
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git", group: :production

# Use foreman to run web and worker on the same Heroku dyno
gem 'foreman', group: :production

ruby '2.0.0'
