require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test "it creates an appointment" do
    appointment_type = appointment_types(:one)
    calendar = calendars(:one)

    Google::Calendar.any_instance.stubs(:add_appointment).returns(true)

    assert_difference("Appointment.count") do
      post appointments_path(calendar: calendar, id: appointment_type),
        params: {
          appointment: {
            start_at: DateTime.now,
            end_at: DateTime.now + 45.minutes,
            creator_name: "Tom Doyle",
            creator_email: "tom.doyle@gmail.com"
          }
        }, xhr: true
    end

    assert_enqueued_emails 2
  end
end
