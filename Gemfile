# frozen_string_literal: true

source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.2"
# The modern asset pipeline for Rails
gem "propshaft"
# Use the Puma web server
gem "puma", ">= 5.0"
# Bundle and transpile JavaScript
gem "jsbundling-rails"
# Hotwire's SPA-like page accelerator
gem "turbo-rails"
# Hotwire's modest JavaScript framework
gem "stimulus-rails"
# Bundle and process CSS
gem "cssbundling-rails"
# Build JSON APIs with ease
gem "jbuilder"
# Forms made easy
gem "simple_form"
# Slim templates for cleaner views
gem "slim-rails"
# Flash messages styling
gem "flash_rails_messages"
# Flexible authentication solution
gem "devise"
# Ancestry for tree structures
gem "ancestry"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]
# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Deploy this application anywhere as a Docker container
gem "kamal", require: false
# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma
gem "thruster", require: false
# Use Active Storage variants
gem "image_processing", "~> 1.2"

group :development, :test do
  # Debugging
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  # Use sqlite3 as the database for development and test
  gem "sqlite3", ">= 2.1"
  # Security audits
  gem "bundler-audit", require: false
  # Static analysis for security vulnerabilities
  gem "brakeman", require: false
  # Ruby styling
  gem "rubocop-rails-omakase", require: false
  # Additional linting
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "slim_lint"
  # IDE support
  gem "solargraph"
  # Test data generation
  gem "faker"
end

group :development do
  # Use console on exceptions pages
  gem "web-console"
  # Convert HTML to Slim
  gem "html2slim"
  # Debug i18n
  gem "i18n-debug"
  # Rails support for Ruby LSP
  gem "ruby-lsp-rails"
end

group :test do
  # System testing
  gem "capybara"
  gem "selenium-webdriver"
  # Better assertions
  gem "minitest-power_assert"
  # Webdrivers for system tests
  gem "webdrivers"
end

group :production do
  # Use PostgreSQL in production (on Render)
  gem "pg"
  # Error tracking in production
  # gem "sentry-rails"
  # gem "sentry-ruby"
  gem "honeybadger"
end
