require "test_helper"

class Dashboard::DashboardWizardControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get dashboard_dashboard_wizard_show_url
    assert_response :success
  end

  test "should get update" do
    get dashboard_dashboard_wizard_update_url
    assert_response :success
  end
end
