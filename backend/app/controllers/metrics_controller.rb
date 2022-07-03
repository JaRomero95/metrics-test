class MetricsController < ApplicationController
  PRESENTER = ::MetricsPresenter

  def create
    metric = MetricsRepository.create(create_params)

    render_data metric
  rescue InvalidModelError => error
    render_errors error.errors
  end

  private

  def create_params
    params.permit(:name, :value, :timestamp)
  end
end
