# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MetricsRepository do
  describe 'filter_by_datetime_range' do
    let(:current_datetime) { Time.zone.now }
    let(:datetime_from) { current_datetime - 1.minute }
    let(:datetime_until) { current_datetime + 1.minute }

    let!(:metric_previous_datetime_from) { create :metric, timestamp: (datetime_from - 1.minute) }
    let!(:metric_in_datetime_from_edge) { create :metric, timestamp: datetime_from }
    let!(:metric_in_rang) { create :metric, timestamp: current_datetime }
    let!(:metric_in_datetime_until_edge) { create :metric, timestamp: datetime_until }
    let!(:metric_after_datetime_until) { create :metric, timestamp: (datetime_until + 1.minute) }

    let(:result) { described_class.filter_by_datetime_range datetime_from:, datetime_until: }

    it 'does not include metric with datetime previous to datetime_from' do
      expect(result).not_to include(metric_previous_datetime_from)
    end

    it 'includes metric with datetime exact to datetime_from' do
      expect(result).to include(metric_in_datetime_from_edge)
    end

    it 'includes metric with datetime between datetime_from and datetime_until' do
      expect(result).to include(metric_in_rang)
    end

    it 'includes metric with datetime exact to datetime_until' do
      expect(result).to include(metric_in_datetime_until_edge)
    end

    it 'does not include metric with datetime after datetime_until' do
      expect(result).not_to include(metric_after_datetime_until)
    end
  end

  shared_examples 'calculates avg by time unit' do |time_unit:, date_format:, date_one:, date_two:|
    let!(:metrics_date_one) { create_list :metric, 2, timestamp: date_one }
    let!(:metrics_date_two) { create :metric, timestamp: date_two }

    let(:result) do
      method_name = "value_average_by_#{time_unit}"

      described_class.public_send method_name, datetime_from: date_one,
                                               datetime_until: Time.zone.now
    end

    it "group metrics by existing #{time_unit}" do
      expect(result.keys.count).to be(3)
    end

    it "calculates average per #{time_unit}" do
      key = date_one.strftime(date_format)

      average = result[key]

      expected_average = (metrics_date_one.sum(&:value) / metrics_date_one.count).round(2)

      expect(average).to eq(expected_average)
    end

    it "fill #{time_unit} without data with 0" do
      key = result.keys.second

      expect(result[key]).to be(0)
    end
  end

  it_behaves_like 'calculates avg by time unit', time_unit: :days,
                                                 date_format: '%Y%m%d',
                                                 date_one: 4.days.ago,
                                                 date_two: 2.days.ago

  it_behaves_like 'calculates avg by time unit', time_unit: :hours,
                                                 date_format: '%Y%m%d%H',
                                                 date_one: 4.hours.ago,
                                                 date_two: 2.hours.ago

  it_behaves_like 'calculates avg by time unit', time_unit: :minutes,
                                                 date_format: '%Y%m%d%H%M',
                                                 date_one: 4.minutes.ago,
                                                 date_two: 2.minutes.ago
end
