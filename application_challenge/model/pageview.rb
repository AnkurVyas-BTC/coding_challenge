# frozen_string_literal: true

# Model to store pageviews
class Pageview < ActiveRecord::Base
  belongs_to :visit
  default_scope { order(timestamp: :asc) }

  before_create :set_position

  def set_position
    self.position = visit.pageviews.count + 1
  end
end
