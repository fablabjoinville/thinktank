source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "~> 3.4.2"

gem "pg", "~> 1.5.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.4.1"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails", ">= 1.2.2"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails", ">= 1.3.3"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", ">= 2.11.5"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 5.0.8"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.17.1", require: false

# Use Sass to process CSS
gem "sassc-rails", ">= 2.1.2"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "active_storage_db", ">= 1.3.0"
gem "activeadmin_addons", ">= 1.10.1"
gem "activeadmin", "~> 3.2.0"
gem "cancancan", ">= 3.5.0"
gem "cpf_cnpj", ">= 0.5.0"
gem "devise", ">= 4.9.2"
gem "phonelib", ">= 0.8.6"
gem "validators", ">= 3.4.2"

gem "stackprof", ">= 0.2.26"
gem "sentry-ruby", ">= 5.16.1"
gem "sentry-rails", ">= 5.16.1"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", ">= 1.9.1", platforms: %i[ mri mingw x64_mingw ]
  gem "faker", ">= 3.2.3"
end

group :development do
  gem "web-console", ">= 4.2.1"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # gem "capybara"
  # gem "selenium-webdriver"
  # gem "webdrivers"
end
