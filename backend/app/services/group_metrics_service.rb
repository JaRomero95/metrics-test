# frozen_string_literal: true

# Calculates average metrics values grouped by days, hours or minutes
class GroupMetricsService
  include ActiveModel::Validations

  attr_reader :group_by, :datetime_from, :datetime_until, :result

  validates :group_by, presence: true, inclusion: { in: %w[days hours minutes] }
  validate :validate_datetime_from
  validate :validate_datetime_until

  def initialize(group_by:, datetime_from:, datetime_until:)
    @group_by = group_by
    @datetime_from = datetime_from
    @datetime_until = datetime_until
  end

  def run
    return false unless valid?

    @result = MetricsRepository.public_send repository_target_method,
                                            datetime_from: @datetime_from,
                                            datetime_until: @datetime_until

    true
  end

  private

  def repository_target_method
    "value_average_by_#{@group_by}"
  end

  def validate_datetime_from
    validate_date('datetime_from')
  end

  def validate_datetime_until
    validate_date('datetime_until')
  end

  def validate_date(date_field)
    value = public_send(date_field)

    return if value.is_a?(ActiveSupport::TimeWithZone)

    instance_variable_set("@#{date_field}", DateTime.parse(value))
  rescue Date::Error
    errors.add(date_field, :invalid_date)
  end
end
