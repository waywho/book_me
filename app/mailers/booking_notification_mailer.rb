class BookingNotificationMailer < ApplicationMailer
  default from: "calendar@timefixr.com"

  def confirm_appointment
    @appointment = Appointment.find(params[:appointment_id])
    @calendar_owner = @appointment.calendar.user
    @appointment_type = @appointment.appointment_type
    @booker_name = @appointment.creator_name
    @booker_email = @appointment.creator_email

    mail(to: @booker_email, subject: "FixR: Confirm new appointment for #{@appointment_type.title} with #{@booker_name}")
  end
end
