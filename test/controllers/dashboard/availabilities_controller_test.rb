require "test_helper"

class Dashboard::AvailabilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @availability = availabilities(:one)
  end

  test "should get index" do
    get dashboard_availabilities_url
    assert_response :success
  end

  test "should get new" do
    get new_dashboard_availability_url
    assert_response :success
  end

  test "should create availability" do
    assert_difference("Availability.count") do
      post dashboard_availabilities_url, params: { availability: {  } }
    end

    assert_redirected_to dashboard_availability_url(Availability.last)
  end

  test "should show availability" do
    get dashboard_availability_url(@availability)
    assert_response :success
  end

  test "should get edit" do
    get edit_dashboard_availability_url(@availability)
    assert_response :success
  end

  test "should update availability" do
    patch dashboard_availability_url(@availability), params: { availability: {  } }
    assert_redirected_to dashboard_availability_url(@availability)
  end

  test "should destroy availability" do
    assert_difference("Availability.count", -1) do
      delete dashboard_availability_url(@availability)
    end

    assert_redirected_to dashboard_availabilities_url
  end
end
