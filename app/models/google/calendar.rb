class Google::Calendar
  attr_reader :user, :calendar

  def initialize(user:, calendar: "primary")
    @calendar = calendar
    @user = user
  end

  def primary_calendar
    @primary_calendar ||= get_calendar
  end

  def calendars
    get_calendars.items
  end

  def events(q: nil)
    get_events(q: q).items.map do |event|
      Google::EventItem.new(event: event)
    end
  end

  def availabilities_by(type)
    get_events(q: type)
  end

  def get_calendars
    @calendars ||= client.list_calendar_lists
  end

  def get_calendar(calendar_id = nil)
    client.get_calendar(calendar_id || calendar)
  end

  def get_events(q: nil, from: nil, in_days: nil)
    from =  Time.now.in_time_zone(primary_calendar.time_zone).at_beginning_of_day.iso8601
    time_max = if in_days
      (Time.new.in_time_zone(primary_calendar.time_zone) + in_days.days).at_end_of_day.iso8601
    end

    client.list_events(calendar, q: q, page_token: nil, time_min: from, time_max: time_max)
  end

  def add_event(event)
    client.insert_event(calendar, event)
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
