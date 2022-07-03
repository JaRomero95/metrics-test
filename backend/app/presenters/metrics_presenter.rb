class MetricsPresenter < Blueprinter::Base
  identifier :id

  fields :name, :value, :timestamp
end
