class CalendarNotificationMailer < ApplicationMailer
  default from: "calendar@timefixr.com"

  def new_appointment
    @appointment = Appointment.find(params[:appointment_id])
    @calendar_owner = @appointment.calendar.user
    @appointment_type = @appointment.appointment_type
    @booker_name = @appointment.creator_name
    @booker_email = @appointment.creator_email

    mail(to: @calendar_owner.email, subject: "FixR: New appointment for #{@appointment_type.title}")
  end
end
