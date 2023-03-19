class CalendarController < ApplicationController
  include PublicCalendarSetter
  before_action :set_calendar
  before_action :set_appointment_type, except: :index
  before_action :authenticate_user!

  def index
    @appointment_types = @calendar.appointment_types
  end

  def show
    if @appointment_type && !@appointment_type.pause?
      free_busy = calendar_service.free_busy_events_by(@appointment_type.availability_identifier)
      @availabilities = free_busy[:availabilities]
      @busy = free_busy[:busy]
    else
      render :appointment_not_availabile
    end
  end
end
