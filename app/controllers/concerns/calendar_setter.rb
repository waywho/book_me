module CalendarSetter
  def set_appointment_type
    @appointment_type = Current.calendar.appointment_types.find(params[:appointment_type_id])
  end
end
