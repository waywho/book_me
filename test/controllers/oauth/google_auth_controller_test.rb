require "test_helper"

class Oauth::GoogleAuthControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get oauth_google_auth_create_url
    assert_response :success
  end
end
