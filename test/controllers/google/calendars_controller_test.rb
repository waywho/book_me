require "test_helper"

class Google::CalendarsControllerTest < ActionDispatch::IntegrationTest

  def setup
    sign_in users(:one)
  end

  test "should get index" do
    get google_calendars_url
    assert_response :success
  end

  test "should get show" do
    get google_calendar_url(id: "primary")
    assert_response :success
  end
end
