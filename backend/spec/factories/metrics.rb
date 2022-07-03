# frozen_string_literal: true

FactoryBot.define do
  factory :metric do
    name { Faker::Finance.stock_market }
    value { rand(0..1000.0).round(2) }
    timestamp { rand(1.week.ago..Time.zone.now) }
  end
end
