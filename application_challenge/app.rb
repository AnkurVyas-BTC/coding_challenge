# frozen_string_literal: true

# require sinatra and active record here
require 'sinatra'
require 'sinatra/activerecord'

# require models here
require './model/pageview'
require './model/visit'

# database configuration
set :database_file, 'database.yml'
