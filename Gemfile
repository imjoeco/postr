source 'https://rubygems.org'

gem 'rails', '~> 3.2.16'
gem 'rack', '~> 1.4.5'

group :production, :mysql do
  gem 'mysql2'
end

group :development, :test do
  gem 'sqlite3'
  gem 'minitest'
  gem 'thor', '= 0.14.6'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'
