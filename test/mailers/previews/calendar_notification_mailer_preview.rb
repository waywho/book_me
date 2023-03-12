# Preview all emails at http://localhost:3000/rails/mailers/calendar_notification_mailer
class CalendarNotificationMailerPreview < ActionMailer::Preview
  def new_appointment
    appointment = Appointment.last
    CalendarNotificationMailer.with(appointment_id: appointment.id).new_appointment
  end

  def cancelled_appointment
    appointment = Appointment.deleted.first
    CalendarNotificationMailer.with(appointment_id: appointment.id).cancelled_appointment
  end
end
