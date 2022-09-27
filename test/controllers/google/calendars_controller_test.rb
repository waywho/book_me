require "test_helper"

class Google::CalendarsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    sign_in users(:one)
    get google_calendars_url
    assert_response :success
  end

  test "should get show" do
    sign_in users(:one)
    get google_calendar_url(id: "primary")
    assert_response :success
  end
end
