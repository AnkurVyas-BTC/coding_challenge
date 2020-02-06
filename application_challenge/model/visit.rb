# frozen_string_literal: true

class Visit < ActiveRecord::Base
  has_many :pageviews
end
