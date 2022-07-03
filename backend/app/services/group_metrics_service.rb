# frozen_string_literal: true

# Calculates average metrics values grouped by days, hours or minutes
class GroupMetricsService
  include ActiveModel::Validations

  attr_reader :group_unit, :datetime_from, :datetime_until

  validates :group_unit, presence: true, inclusion: { in: %w[days hours minutes] }

  class << self
    def run(group_unit:, datetime_from:, datetime_until:)
      new(group_unit:, datetime_from:, datetime_until:).tap(&:run)
    end
  end

  def initialize(group_unit:, datetime_from:, datetime_until:)
    @group_unit = group_unit
    @datetime_from = datetime_from
    @datetime_until = datetime_until
  end

  def run
    return unless valid?

    MetricsRepository.public_send repository_target_method, datetime_from: @datetime_from,
                                                            datetime_until: @datetime_until
  end

  private

  def repository_target_method
    "value_average_by_#{@group_unit}"
  end
end
