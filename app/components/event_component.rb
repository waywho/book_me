# frozen_string_literal: true

class EventComponent < ViewComponent::Base
  def initialize(event:, width: :card)
    @event = event
    @width = width
  end

  def date
    "#{l @event.start_at, format: :weekday} #{l @event.start_at, format: :short_date}"
  end

  def time_period
    "#{l @event.start_at, format: :short_time} - #{l @event.end_at, format: :short_time}"
  end

  private

  def width
    case @width
    when :full
      "w-full"
    else
      "w-56"
    end
  end
end
