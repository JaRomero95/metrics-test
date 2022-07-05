# frozen_string_literal: true

# Utility methods for controller testing
module ControllerHelpers
  def json_response
    JSON.parse response.body
  end
end
