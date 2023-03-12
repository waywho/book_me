class CalendarNotificationMailer < ApplicationMailer
  default from: "calendar@timefixr.com"

  def new_appointment
    @appointment = Appointment.find(params[:appointment_id])
    @calendar = @appointment.calendar
    @appointment_type = @appointment.appointment_type
    @booker_name = @appointment.creator_name
    @booker_email = @appointment.creator_email

    mail(to: @calendar.user.email, subject: t(".subject", title: @appointment_type.title, person: @booker_name))
  end

  def cancelled_appointment
    @appointment = Appointment.with_deleted.find(params[:appointment_id])
    @calendar = @appointment.calendar
    @appointment_type = @appointment.appointment_type
    @booker_name = @appointment.creator_name
    @booker_email = @appointment.creator_email

    mail(to: @calendar.user.email, subject: t(".subject", title: @appointment_type.title, person: @booker_name))
  end
end
