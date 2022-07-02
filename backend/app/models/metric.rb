# frozen_string_literal: true

class Metric < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true, numericality: true
  validates :timestamp, presence: true

  scope :datetime_from, ->(datetime) { where('timestamp >= ?', datetime) }
  scope :datetime_until, ->(datetime) { where('timestamp <= ?', datetime) }
end
