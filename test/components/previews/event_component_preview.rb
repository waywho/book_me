# frozen_string_literal: true

class EventComponentPreview < ViewComponent::Preview
  def default
    calendar = Calendar.new(
      user: User.first,
      provider: "google_oauth2"
    )
    event = Event.new(
      title: "Best Appointment",
      description: "It will be very useful",
      location: "https://at/this/address",
      start_datetime: DateTime.now,
      end_datetime: 1.hour.from_now,
      creator_name: "Elaine Page",
      creator_email: "elaine@isingjazz.com",
      calendar: calendar
    )
    render(EventComponent.new(event: event))
  end
end
