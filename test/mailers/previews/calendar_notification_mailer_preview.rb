# Preview all emails at http://localhost:3000/rails/mailers/calendar_notification_mailer
class CalendarNotificationMailerPreview < ActionMailer::Preview
  def new_appointment
    appointment = Appointment.last
    CalendarNotificationMailer.with(appointment_id: appointment.id).new_appointment
  end
end
