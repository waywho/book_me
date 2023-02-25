class Events::RecurringEvent < Events::Base
  attr_reader :event, :title, :creator_name, :creator_email, :start_at, :end_at, :status, :description, :time_zone
  def initialize(event:, recurring_date:)
    @event = event
    @title = @event.summary
    @creator_name = @event.creator&.display_name
    @creator_email = @event.creator&.email
    @recurring_date = recurring_date
    @status =  @event.status || "confirmed"
    @description = @event.description
    @time_zone = @event.start&.time_zone
  end

  def start_date
    Date.new(@recurring_date.year, @recurring_date.month, @recurring_date.day)
  end

  def end_date
    Date.new(@recurring_date.year, @recurring_date.month, @recurring_date.day)
  end

  def start_at
    DateTime.new(@recurring_date.year,
                 @recurring_date.month,
                 @recurring_date.day,
                 @event.start&.date_time&.hour,
                 @event.start&.date_time&.minute,
                 0,
                 @recurring_date.zone)
  end

  def end_at
    DateTime.new(@recurring_date.year,
                 @recurring_date.month,
                 @recurring_date.day,
                 @event.end&.date_time&.hour,
                 @event.end&.date_time&.minute,
                 0,
                 @recurring_date.zone)
  end
end
