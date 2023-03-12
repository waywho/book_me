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
    all_events = get_events(q: q).items

    @events ||= all_events.flat_map do |event|
      if event.recurrence.blank?
        Google::EventItem.new(event: event)
      else
        exdates = all_events.map { |e| e.original_start_time.date_time if e.recurring_event_id && e.recurring_event_id == event.id }.compact
        Scheduler::Events.schedule(event, exdates: exdates).events
      end
    end
  end

  def availabilities_by(uid)
    get_events(q: uid).items.map do |event|
      Google::EventItem.new(event: event)
    end
  end

  def free_busy_events_by(availability_uid)
    events.each_with_object({ busy: [], availabilities: []}) do |event, h|
      next if event.status != "confirmed"

      if event.description&.include?(availability_uid)
        h[:availabilities] << event
      else
        h[:busy] << event
      end
    end
  end

  def get_calendars
    @calendars ||= client.list_calendar_lists
  end

  def get_calendar(calendar_id = nil)
    client.get_calendar(calendar_id || calendar)
  end

  def get_events(q: nil, from: nil, in_days: 30)
    from =  Time.now.in_time_zone(primary_calendar.time_zone).at_beginning_of_day.iso8601
    time_max = if in_days
      (Time.new.in_time_zone(primary_calendar.time_zone) + in_days.days).at_end_of_day.iso8601
    end

    # Rails.cache.fetch("google-calendar-#{primary_calendar.id}", expires_in: 1.hour) do
      client.list_events(calendar, q: q, page_token: nil, time_min: from, time_max: time_max)
    # end
  end

  def add_event_by(appointment_type_hash, start_at:, end_at:)
    start_time = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: start_at.iso8601,
      time_zone: current_time_zone)
    end_time = Google::Apis::CalendarV3::EventDateTime.new(date_time: end_at.iso8601,
      time_zone: current_time_zone)

    appointment_type_hash.merge!(
      start: start_time,
      end: end_time
    )

    event = Google::Apis::CalendarV3::Event.new(**appointment_type_hash)

    add_event(event)
  end

  def add_appointment(appointment)
    r = add_event_by(
      appointment.template_info,
      start_at: appointment.start_at,
      end_at: appointment.end_at
    )

    appointment.update(identifier: r.id) && r.status == "confirmed"
  end

  def cancel_appointment(appointment)
    r = client.delete_event(calendar, appointment.identifier)

    r.blank?
  end

  private

  def add_event(event)
    client.insert_event(calendar, event)
  end

  def current_time_zone
    ActiveSupport::TimeZone::MAPPING[Time.zone.name]
  end

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
