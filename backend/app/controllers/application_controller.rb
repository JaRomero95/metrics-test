# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_index(data)
    render json: {data:}, status: :ok
  end

  def render_errors(errors)
    render json: {errors:}, status: :bad_request
  end
end
