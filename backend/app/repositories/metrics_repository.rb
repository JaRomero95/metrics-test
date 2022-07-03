# frozen_string_literal: true

class MetricsRepository < ApplicationRepository
  class << self
    def filter_by_datetime_range(datetime_from:, datetime_until:)
      Metric.datetime_from(datetime_from).datetime_until(datetime_until)
    end

    def value_average_by_days(datetime_from:, datetime_until:)
      value_average_by(date_format: day_date_format, datetime_from:, datetime_until:)
    end

    def value_average_by_hours(datetime_from:, datetime_until:)
      value_average_by(date_format: hour_date_format, datetime_from:, datetime_until:)
    end

    def value_average_by_minutes(datetime_from:, datetime_until:)
      value_average_by(date_format: minute_date_format, datetime_from:, datetime_until:)
    end

    private

    def value_average_by(date_format:, datetime_from:, datetime_until:)
      filter_by_datetime_range(datetime_from:, datetime_until:)
        .group("strftime('#{date_format}', timestamp)")
        .average(:value)
        .transform_values { |value| value.round(2) }
    end

    def day_date_format
      '%Y%m%d'
    end

    def hour_date_format
      "#{day_date_format}%H"
    end

    def minute_date_format
      "#{hour_date_format}%M"
    end
  end
end
