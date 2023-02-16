class AddAvailabilityToGoolgeCalendarJob < ApplicationJob
  queue_as :default

  def perform(calendar_id:,
              appointment_type_id:,
              user_id:,
              test: false)
    user = User.find(user_id)
    calendar = user.calendars.find(calendar_id)
    availability_template = calendar.appointment_types.find(appointment_type_id).template_info

    client = Google::Calendar.new(user: user, calendar: calendar.identifier)

    availability_template[:description] += " TEST" if test

    client.add_event_by(
      availability_template,
      start_at: (Time.now.in_time_zone(calendar.time_zone).at_beginning_of_day + 9.hours),
      end_at: (Time.now.in_time_zone(calendar.time_zone).at_beginning_of_day + 17.hours)
    )

    Rails.logger.info "Google Event Created #{result.html_link}"
  end
end
