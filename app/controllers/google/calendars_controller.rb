class Google::CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_token, :set_calendar_client

  def index
    @calendars = @calendar_client.list_calendar_lists.items
  end

  def show
    @calendar = @calendar_client.get_calendar("primary")
  end

  def create
    google_calendar = @calendar_client.get_calendar_list(params[:calendar_id])

    unless calendar = user.calendars.find_by(identifier: google_calendar.id)
      calendar = current_user.calendars.create(
        service: "google",
        identifier: google_calendar.id,
        summary: google_calendar.summary,
        description: google_calendar.description,
        time_zone: google_calendar.time_zone,
        primary: google_calendar.primary,
        etag: google_calendar.etag
      )
    end

    redirect_to google_calendar_path(calendar)
  end

  private

  def set_token
    @token = current_user.google_token
    @token.refresh! if @token.expired?
  end

  def set_calendar_client
    @calendar_client = Google::Apis::CalendarV3::CalendarService.new
    @calendar_client.authorization = @token.google_secret.to_authorization
  end
end
