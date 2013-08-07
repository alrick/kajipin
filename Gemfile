source 'https://rubygems.org'

gem 'rails', '3.2.13'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3' #sass for better css
  gem 'uglifier', '>= 1.0.3' # for javascript
  gem "therubyracer" #required for twitter-bootstrap-rails
  gem 'hogan_assets' #used to render html template, typeahead
end

gem 'coffee-rails', '~> 3.2.1' #coffee for better javascript
gem 'jquery-rails' #jquery integration
gem 'pg' #postgres database
gem 'json' #self explained
gem 'devise' #authentification system
gem 'thin' #thin server
gem 'simple_form' #better forms
gem 'rabl' #manage json formating, MUST BE before gon
gem 'oj' #json parser for rabl
gem 'gon' #passing data to javascript
gem 'nokogiri' #xml parsing
gem 'less-rails' #required for twitter-bootstrap-rails
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git' #bootstrap for better interface
gem 'kaminari' #pagination system
gem 'cancan' #authorization library
gem 'madmimi' #interaction with madmimi email marketing
gem 'figaro' #config variables made easy
gem 'httparty' #http request with fun :D
gem 'leaflet-markercluster' #clusters for leaflet/mapbox
#waiting 0.10 for dupcheck gem 'twitter-typeahead-rails' #typeahead by twitter, better than bootstrap one
gem 'spinjs-rails' #smart js spinner
gem 'jquery-hoverIntent-rails' #better jquery hover for users
gem 'newrelic_rpm' #monitoring service

group :development do
  gem 'rails-erd' #create schema of entities
  gem 'hirb' #better visualisation in rails console
  gem 'faker' #used to create fake resources easily
  gem 'nifty-generators' #better scaffold generators
  gem 'rubocop' #a Ruby code style checker
end

# To use debugger
# gem 'debugger'

gem 'mocha', :group => :test