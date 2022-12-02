require "test_helper"

class Dashboard::AppointmentTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @appointment_type = appointment_types(:one)
  end

  test "should get index" do
    get dashboard_appointment_types_url
    assert_response :success
  end

  test "should get new" do
    get new_dashboard_appointment_type_url
    assert_response :success
  end

  test "should create appointment_type" do
    assert_difference("AppointmentType.count") do
      post dashboard_appointment_types_url, params: { appointment_type: {
        user_id: @user.id,
        title: "TEST",
        description: "Great Appointment",
        location: "This Place",
        duration: 1
      } }
    end

    assert_redirected_to dashboard_appointment_type_url(AppointmentType.last)
  end

  test "should show appointment_type" do
    get dashboard_appointment_type_url(@appointment_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_dashboard_appointment_type_url(@appointment_type)
    assert_response :success
  end

  test "should update appointment_type" do
    patch dashboard_appointment_type_url(@appointment_type), params: { appointment_type: { tite: "NEW NAME" } }
    assert_redirected_to dashboard_appointment_type_url(@appointment_type)
  end

  test "should destroy appointment_type" do
    assert_difference("AppointmentType.count", -1) do
      delete dashboard_appointment_type_url(@appointment_type)
    end

    assert_redirected_to dashboard_appointment_types_url
  end
end
