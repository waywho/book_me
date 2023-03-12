# Preview all emails at http://localhost:3000/rails/mailers/booker_notification_mailer
class BookingNotificationMailerPreview < ActionMailer::Preview
  def confirm_appointment
    appointment = Appointment.last
    BookingNotificationMailer.with(appointment_id: appointment.id).confirm_appointment
  end

  def cancelled_appointment
    appointment = Appointment.deleted.first
    BookingNotificationMailer.with(appointment_id: appointment.id).cancelled_appointment
  end
end
