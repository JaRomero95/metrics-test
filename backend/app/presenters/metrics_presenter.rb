# frozen_string_literal: true

class MetricsPresenter < Blueprinter::Base
  identifier :id

  fields :name, :value, :timestamp
end
