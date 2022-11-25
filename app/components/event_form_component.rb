# frozen_string_literal: true

class EventFormComponent < ViewComponent::Base
  def initialize(event:, path: nil, method: :post)
    @event = event
    @path = path
    @method = method
  end
end
