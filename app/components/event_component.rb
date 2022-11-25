# frozen_string_literal: true

class EventComponent < ViewComponent::Base
  def initialize(event:)
    @event = event
  end

  def time_duration
    "#{l @event.start_datetime, format: :short} - #{l @event.end_datetime, format: :short}"
  end
end
