require 'yaml'
require 'active_record'

# Not needed in contest of rails
# DB_CONFIG = YAML.load(File.open('config/database.yml'))[ENV['RAILS_ENV']].freeze

# ActiveRecord::Base.establish_connection(DB_CONFIG)

Dir['app/models/*.rb'].each { |f| require "./#{f}"}