class Google::Calendar
  attr_reader :user, :calendar

  def initialize(user:, calendar: "primary")
    @calendar = calendar
    @user = user
  end

  def primary_calendar
    [get_calendar]
  end

  def calendars
    get_calendars.items
  end

  def events
    get_events.items.map do |event|
      Google::Event.new(event: event)
    end
  end

  def availabilities_by(type)
    get_events(q: type)
  end

  def get_calendars
    client.list_calendar_lists
  end

  def get_calendar
    client.get_calendar(calendar)
  end

  def get_events(q: nil)
    client.list_events(calendar, q: q, page_token: nil)
  end

  private

  def token
    @token = user.google_token
    @token.refresh! if @token.expired?
    @token
  end

  def client
    @client ||= Google::Apis::CalendarV3::CalendarService.new
    @client.authorization = token.google_secret.to_authorization
    @client
  end
end
