source 'https://rubygems.org'

gem 'rails', '3.2.11'  # specific rails!

# Gems for frontend coding!
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby # javascript engine
  gem 'uglifier', '>= 1.0.3' # crunches the js/css files
end

# frontend coding gems
gem "haml", ">= 3.1.7"
gem "haml-rails", ">= 0.3.5", :group => :development
gem 'jquery-rails', ">= 2.1.4"
gem "bootstrap-sass", ">= 2.2.2.0" # this is to install twitter bootstrap sass stuff
gem 'draper', '~> 1.0'
#gem "simple_form", ">= 2.0.4"

# web server
gem "passenger", ">= 3.0.19"
#gem "unicorn", ">= 4.3.1"

# database
gem "sqlite3"
#gem "mysql2", ">= 0.3.11"

# some cool development tools?
group :development do
  gem "ruby_parser", ">= 3.1.1"
  gem "better_errors", ">= 0.3.2"
  gem "binding_of_caller", ">= 0.6.8"

  # for unit testing
  #gem "rspec-rails", ">= 2.11.4"
  #gem "factory_girl_rails", ">= 4.1.0"
end

# Deploy with Capistrano
gem 'capistrano', :group => :development
gem 'rvm-capistrano', "1.3.0.rc1"


# unit test framework and all the other cool stuff for test environment
group :test do
  #gem "rspec-rails", ">= 2.11.4"
  #gem "capybara", ">= 2.0.1"
  #gem "database_cleaner", ">= 0.9.1"
  #gem "email_spec", ">= 1.4.0"
  #gem "factory_girl_rails", ">= 4.1.0"
end