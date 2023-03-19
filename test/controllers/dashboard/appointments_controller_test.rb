require "test_helper"

class Dashboard::AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @appointment = events(:appointment_one)
    @calendar = calendars(:one)
  end

  test "should get show" do
    get dashboard_appointment_path(@appointment)
    assert_response :success
  end
end
