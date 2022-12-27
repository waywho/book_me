class AddAvailabilityToGoolgeCalendarJob < ApplicationJob
  queue_as :default

  def perform(calendar_id:,
              appointment_type_id:,
              user_id:,
              test: false)
    user = User.find(user_id)
    calendar = user.calendars.find(calendar_id)
    availability_template = calendar.appointment_types.find(appointment_type_id).availability_template_info

    client = Google::Calendar.new(user: user, calendar: calendar.identifier)

    template_hash = availability_template.merge(
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: (Time.now.in_time_zone(primary_calendar.time_zone).at_beginning_of_day + 9.hours).iso8601,
        time_zone: ActiveSupport::TimeZone::MAPPING[Time.zone.name]
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: (Time.now.in_time_zone(primary_calendar.time_zone).at_beginning_of_day + 17.hours).iso8601,
        time_zone: ActiveSupport::TimeZone::MAPPING[Time.zone.name]
      )
    )

    template_hash[:description] += ":test"

    event = Google::Apis::CalendarV3::Event.new(
      **template_hash
    )

    result = client.add_event(event)

    Rails.logger.info "Google Event Created #{result.html_link}"
  end
end
