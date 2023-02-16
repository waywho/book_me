require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test "it creates an appointment" do
    appointment_type = appointment_types(:one)
    calendar = calendars(:one)

    assert_difference("Appointment.count") do
      post appointments_path(calendar: calendar, id: appointment_type),
        params: {
          appointment: {
            start_at: DateTime.now,
            creator_name: "Tom Doyle",
            creator_email: "tom.doyle@gmail.com"
          }
        }
    end

    # mock = Minitest::Mock.new
    # Google::Calendar.stub :add_event
  end
end
