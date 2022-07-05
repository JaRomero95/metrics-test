# frozen_string_literal: true

class MetricsRepository < ApplicationRepository
  MODEL = Metric

  class << self
    def filter_by_datetime_range(datetime_from:, datetime_until:)
      Metric.datetime_from(datetime_from).datetime_until(datetime_until)
    end

    def value_average_by_days(datetime_from:, datetime_until:)
      value_average_by(group_by: 'day', datetime_from:, datetime_until:)
    end

    def value_average_by_hours(datetime_from:, datetime_until:)
      value_average_by(group_by: 'hour', datetime_from:, datetime_until:)
    end

    def value_average_by_minutes(datetime_from:, datetime_until:)
      value_average_by(group_by: 'minute', datetime_from:, datetime_until:)
    end

    private

    def value_average_by(group_by:, datetime_from:, datetime_until:)
      method_name = "group_by_#{group_by}"
      date_format = send("#{group_by}_date_format")

      filter_by_datetime_range(datetime_from:, datetime_until:)
        .public_send(method_name, :timestamp, format: date_format)
        .average(:value)
        .transform_values { |value| value ? value.round(2) : 0 }
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
