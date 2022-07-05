# frozen_string_literal: true

class MetricsController < ApplicationController
  PRESENTER = ::MetricsPresenter

  def create
    metric = MetricsRepository.create(create_params)

    render_data metric
  rescue InvalidModelError => e
    render_errors e.errors
  end

  private

  def create_params
    params.permit(:name, :value, :timestamp)
  end
end
