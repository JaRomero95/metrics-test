# frozen_string_literal: true

class InvalidModelError < StandardError
  attr_reader :errors

  def initialize(errors)
    @errors = errors
    super('Model has validation errors')
  end
end

class ApplicationRepository
  MODEL = nil

  class << self
    def create(data)
      instance = self::MODEL.create(data)

      raise(InvalidModelError, instance.errors) if instance.invalid?

      OpenStruct.new(instance.attributes)
    end
  end
end
