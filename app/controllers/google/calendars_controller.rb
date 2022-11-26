class Google::CalendarsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_token, :set_calendar_client
  before_action :set_calendar_service

  def index
    @google_calendars = @calendar_service.calendars
    @calendars = current_user.calendars
  end

  def show
    @calendar = Calendar.find(params[:id])
    @google_calendar = @calendar_service
  end

  def create
    google_calendar = @calendar_client.get_calendar_list(params[:id])

    @calendar = current_user.calendars.where(identifier: google_calendar.id).first_or_create do |calendar|
        calendar.provider = "google_oauth2"
        calendar.identifier = google_calendar.id
        calendar.summary = google_calendar.summary
        calendar.description = google_calendar.description
        calendar.time_zone = google_calendar.time_zone
        calendar.primary = google_calendar.primary
        calendar.etag = google_calendar.etag.gsub("\"", "")
    end

    redirect_to google_calendar_path(@calendar) if @calendar.persisted?
  end

  private

  def set_calendar_service
    @calendar_service = Google::Calendar.new(user: current_user)
  end

  # def set_token
  #   @token = current_user.google_token
  #   @token.refresh! if @token.expired?
  # end

  # def set_calendar_client
  #   @calendar_client = Google::Apis::CalendarV3::CalendarService.new
  #   @calendar_client.authorization = @token.google_secret.to_authorization
  # end
end
