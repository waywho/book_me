module PublicCalendarSetter
  def set_calendar
    @calendar = Calendar.friendly.find(params[:calendar])
  end

  def set_appointment_type
    @appointment_type = @calendar.appointment_types.friendly.find(params[:id])
  end

  private

  def calendar_service
    @calendar_service ||= Google::Calendar.new(user: @calendar.user)
  end
end
