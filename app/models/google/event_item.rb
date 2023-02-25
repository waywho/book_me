class Google::EventItem < Events::Base
  attr_reader :event, :title, :creator_name, :creator_email, :start_at, :end_at, :start_date, :end_date, :time_zone
  delegate :description, :location, :status, :recurrance, to: :event

  def initialize(event:)
    @event = event
    @title = @event.summary
    @creator_name = @event.creator&.display_name
    @creator_email = @event.creator&.email
    @start_date = @event.start&.date_time&.to_date
    @end_date = @event.end&.date_time&.to_date
    @start_at = @event.start&.date_time
    @end_at = @event.end&.date_time
    @time_zone = @event.start&.time_zone
  end
end
