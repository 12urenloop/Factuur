source 'https://rubygems.org'

ruby "3.3.1"

gem 'dotenv-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0'
# Use Puma as the app server
gem 'puma', '< 6'

# Use SCSS for stylesheets
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Paranoia
gem 'paranoia'

# Bulma is CSS bae
gem 'bulma-rails'

# Slim templating <3
gem 'slim-rails'

# i18n
gem 'rails-i18n'

# JQuery
gem "jquery-rails"

# fancy selection
gem "select2-rails"

# Dynamic forms
gem 'cocoon'

# Sentry
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'stackprof'

# Font Awesome
gem 'font-awesome-rails'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# PDF goodies
gem 'grover'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'

  gem 'rspec'

  gem 'mimemagic'

  # Time sensitive tests
  gem 'timecop'

  # Fake stuff
  gem 'faker'

  # Deployment
  gem "capistrano", "~> 3.11", require: false
  gem 'capistrano-docker', github: 'TomNaessens/capistrano-docker'
  gem 'ed25519', require: false
  gem 'bcrypt_pbkdf', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Livereload
  gem 'guard'
  gem 'guard-livereload', '~> 2.5', require: false

  # rails_panel
  gem 'meta_request'

  # Annotations are cool
  gem 'annotate'

  # Fix rails c issue
  gem 'rb-readline'
end

group :production do
  gem 'mysql2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
