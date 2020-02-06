# frozen_string_literal: true

class Pageview < ActiveRecord::Base
  belongs_to :visit
end
