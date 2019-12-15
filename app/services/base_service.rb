# frozen_string_literal: true

# Base Service Interface that other services inherit from
class BaseService
  private_class_method :new

  def self.call(*args)
    new(*args).call
  end
end
