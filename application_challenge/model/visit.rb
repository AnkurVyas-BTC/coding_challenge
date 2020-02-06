# frozen_string_literal: true

# Model to store visits
class Visit < ActiveRecord::Base
  has_many :pageviews
  REFERRER_NAME_REGEX = /\A[A-z0-9_]{13}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/.freeze

  validates :evid, format: {
    with: REFERRER_NAME_REGEX,
    message: 'is not in correct format'
  }
end
