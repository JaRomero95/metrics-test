# frozen_string_literal: true

class GroupMetricsController < ApplicationController
  def index
    datetime_from = filter_params.fetch(:datetime_from, 5.minutes.ago)
    datetime_until = filter_params.fetch(:datetime_until, Time.zone.now)
    group_by = params.fetch(:group_by, 'minutes')

    service = GroupMetricsService.new(group_by:, datetime_from:, datetime_until:)

    if service.run
      render_data service.result
    else
      render_errors service.errors
    end
  end

  private

  def filter_params
    params.fetch(:filter, {})
  end
end
