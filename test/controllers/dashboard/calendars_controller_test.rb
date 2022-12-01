require "test_helper"

class Dashboard::CalendarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_calendar = user_calendars(:one)
  end

  test "should get new" do
    get new_user_calendar_url
    assert_response :success
  end

  test "should create user_calendar" do
    assert_difference("User::Calendar.count") do
      post user_calendars_url, params: { user_calendar: {  } }
    end

    assert_redirected_to user_calendar_url(User::Calendar.last)
  end

  test "should show user_calendar" do
    get user_calendar_url(@user_calendar)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_calendar_url(@user_calendar)
    assert_response :success
  end

  test "should update user_calendar" do
    patch user_calendar_url(@user_calendar), params: { user_calendar: {  } }
    assert_redirected_to user_calendar_url(@user_calendar)
  end

  test "should destroy user_calendar" do
    assert_difference("User::Calendar.count", -1) do
      delete user_calendar_url(@user_calendar)
    end

    assert_redirected_to user_calendars_url
  end
end
