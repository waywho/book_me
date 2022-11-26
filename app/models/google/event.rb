class Google::Event
  attr_reader :event, :title, :creator_name, :creator_email, :start_datetime, :end_datetime
  delegate :description, :location, to: :event

  def initialize(event:)
    @event = event
    @title = @event.summary
    @creator_name = @event.creator.display_name
    @creator_email = @event.creator.email
    @start_datetime = @event.start.date_time
    @end_datetime = @event.end.date_time
  end
end
