# frozen_string_literal: true

class ApplicationController < ActionController::API
  PRESENTER = nil

  def render_data(data)
    data = presenter.render_as_json(data) if presenter

    render json: { data: }, status: :ok
  end

  def render_errors(errors)
    render json: { errors: }, status: :bad_request
  end

  def presenter
    self.class::PRESENTER
  end
end
