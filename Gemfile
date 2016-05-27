source 'https://rubygems.org'

ruby '2.1.7'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.6'
# gem 'sass-rails', '~> 5.0', '>= 5.0.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-script-source', '1.8.0'
gem "font-awesome-rails"
# gem 'devise'
gem 'devise', '~> 3.5', '>= 3.5.6'
gem "recaptcha", require: "recaptcha/rails"
gem "twitter-bootstrap-rails"
gem "paperclip", "~> 4.3"
gem 'figaro'
gem 'country_select'
gem 'friendly_id', '~> 5.1.0'
gem 'cocoon'
gem 'mailboxer'
gem "select2-rails"
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'bootstrap-filestyle-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'gravatar_image_tag'
gem 'chosen-rails'
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'will_paginate', '~> 3.0.6'
gem 'summernote-rails'
gem 'themes_on_rails', '~> 0.4.0'
gem 'wicked', '~> 1.3'
gem 'jquery-minicolors-rails'#for color selector
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
gem 'icheck-rails'
gem 'refile', '~> 0.6.2', github: 'refile/refile', require: "refile/rails"
gem "refile-mini_magick"
# gem "refile-s3"
gem 'high_voltage', '~> 3.0'
# gem "refile", require: ["refile/rails", "refile/image_processing"]
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
	# Use mysql as the database for Active Record
	gem 'mysql2', '>= 0.3.13', '< 0.5'   
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0' 
end

group :production do
	gem 'pg'
	gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
