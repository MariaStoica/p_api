source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.1.6'
gem 'sass-rails', '~> 4.0.2'
gem 'bootstrap-sass', '2.3.2.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'kaminari'
gem 'sqlite3'

# for aws
gem 'puma'
# Use Authy for sending one time password through sms
gem 'authy'
# Use Twilio to send confirmation message
gem 'twilio-ruby', '~> 3.12'
# for having images in the database
gem "paperclip", "~> 4.2"

# User Auth
# I'll just make my own
gem 'bcrypt'
# gem 'devise' # can't get authentication with auth_token with devise
# gem 'simple_token_authentication'
# gem 'rails_12factor', group: :production # tweaks for devise to work on heroku

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  
  gem 'byebug'
  gem 'web-console'
  gem 'spring'
end

group :production do
  #gem 'pg'
  gem 'rails_12factor'
  #gem 'unicorn'
end



