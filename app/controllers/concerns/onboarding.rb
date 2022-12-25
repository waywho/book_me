module Onboarding

  private

  def get_primary_calendar
    @external_calendar = calendar_service.primary_calendar
    calendars = current_user.calendars
    @connected_calendar = calendars.find_by(identifier: @external_calendar.id)
  end

  def find_or_create_calendar
    current_user.calendars.where(identifier: calendar_service.get_calendar(params[:calendar_id])&.id).first_or_create do |calendar|
      calendar.provider = "google_oauth2"
      calendar.identifier = google_calendar.id
      calendar.summary = google_calendar.summary
      calendar.description = google_calendar.description
      calendar.time_zone = google_calendar.time_zone
      calendar.primary = google_calendar.primary
      calendar.etag = google_calendar.etag.gsub("\"", "")
    end
  end
end
