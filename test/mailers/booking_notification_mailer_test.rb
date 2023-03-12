require "test_helper"

class BookingNotificationMailerTest < ActionMailer::TestCase
  test "confirm appointment" do
    appointment = events(:appointment_one)
    email = BookingNotificationMailer.with(appointment_id: appointment.id).confirm_appointment
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, [appointment.creator_email]
    assert_equal email.from, ["calendar@timefixr.com"]
    assert_equal email.subject, I18n.t("booking_notification_mailer.confirm_appointment.subject", title: appointment.title, person: appointment.calendar.user.full_name)
  end

  test "cancelled appointment" do
    appointment = events(:appointment_cancelled)
    email = BookingNotificationMailer.with(appointment_id: appointment.id).cancelled_appointment
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, [appointment.creator_email]
    assert_equal email.from, ["calendar@timefixr.com"]
    assert_equal email.subject, I18n.t("booking_notification_mailer.cancelled_appointment.subject", title: appointment.title, person: appointment.calendar.user.full_name)
  end
end
