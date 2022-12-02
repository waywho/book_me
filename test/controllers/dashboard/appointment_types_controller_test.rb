require "test_helper"

class Dashboard::AppointmentTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @appointment_type = appointment_types(:one)
    @calendar = calendars(:one)
  end

  test "should get index" do
    get dashboard_appointment_types_url(calendar_id: @calendar.id)
    assert_response :success
  end

  test "should get new" do
    get new_dashboard_appointment_type_url(calendar_id: @calendar.id)
    assert_response :success
  end

  test "should create appointment_type" do
    assert_difference("AppointmentType.count") do
      post dashboard_appointment_types_url(calendar_id: @calendar.id),
        params: { appointment_type: {
          user_id: @user.id,
          title: "TEST",
          description: "Great Appointment",
          location: "This Place",
          duration: 1
        } }
    end

    assert_redirected_to dashboard_appointment_type_url(AppointmentType.last, calendar_id: @calendar.id)
  end

  test "should show appointment_type" do
    get dashboard_appointment_type_url(@appointment_type, calendar_id: @calendar.id)
    assert_response :success
  end

  test "should get edit" do
    get edit_dashboard_appointment_type_url(@appointment_type, calendar_id: @calendar.id)
    assert_response :success
  end

  test "should update appointment_type" do
    patch dashboard_appointment_type_url(@appointment_type, calendar_id: @calendar.id), params: { appointment_type: { tite: "NEW NAME" } }
    assert_redirected_to dashboard_appointment_type_url(@appointment_type)
  end

  test "should destroy appointment_type" do
    assert_difference("AppointmentType.count", -1) do
      delete dashboard_appointment_type_url(@appointment_type, calendar_id: @calendar.id)
    end

    assert_redirected_to dashboard_appointment_types_url
  end
end
