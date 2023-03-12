require "test_helper"

class CalendarNotificationMailerTest < ActionMailer::TestCase
  test "new appointment" do
    appointment = events(:appointment_two)
    email = CalendarNotificationMailer.with(appointment_id: appointment.id).new_appointment
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, [appointment.calendar.user.email]
    assert_equal email.from, ["calendar@timefixr.com"]
    assert_equal email.subject, I18n.t("calendar_notification_mailer.new_appointment.subject", title: appointment.title, person: appointment.creator_name)
  end
end
