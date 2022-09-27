class CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_token, :set_calendar_client

  def index
    @calendars = @calendar_client.list_calendar_lists.items
  end

  def show
    @calendar = @calendar_client.get_calendar("primary")
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
