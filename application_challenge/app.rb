# frozen_string_literal: true

# require sinatra and active record here
require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require 'net/http'

# require models here
require './model/pageview'
require './model/visit'

# database configuration
set :database_file, 'database.yml'

def call
  save_to_database(api_response)
end

def api_response
  response = Net::HTTP.get_response('secure-cliffs-06348.herokuapp.com', '/')
  JSON.parse(response.body)
end

def save_to_database(parsed_response)
  parsed_response.each do |result|
    visit = initialize_visit(result)
    save_pageviews(result['actionDetails'], visit) if visit.save
  end
end

def initialize_visit(result)
  Visit.new(evid: result['referrerName'],
            vendor_site_id: result['idSite'],
            vendor_visit_id: result['idVisit'],
            visit_ip: result['visitIp'],
            vendor_visitor_id: result['visitoriId'])
end

def save_pageviews(action_details, visit)
  action_details.each do |detail|
    next unless Pageview.find_by(url: detail['url']).nil?

    visit.pageviews.create(
      title: detail['pageTitle'],
      url: detail['url'],
      time_spent: detail['timeSpent'],
      timestamp: detail['timestamp']
    )
  end
end
