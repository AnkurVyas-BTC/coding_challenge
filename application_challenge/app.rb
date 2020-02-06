# frozen_string_literal: true

# require sinatra and active record here
require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

# require models here
require './model/pageview'
require './model/visit'

# database configuration
set :database_file, 'database.yml'

get '/' do
  @visits = Visit.all
  puts @visits
end
