require "application_system_test_case"

class AppointmentTypesTest < ApplicationSystemTestCase
  setup do
    @appointment_type = appointment_types(:one)
  end

  test "visiting the index" do
    visit appointment_types_url
    assert_selector "h1", text: "Appointment types"
  end

  test "should create appointment type" do
    visit appointment_types_url
    click_on "New appointment type"

    click_on "Create Appointment type"

    assert_text "Appointment type was successfully created"
    click_on "Back"
  end

  test "should update Appointment type" do
    visit appointment_type_url(@appointment_type)
    click_on "Edit this appointment type", match: :first

    click_on "Update Appointment type"

    assert_text "Appointment type was successfully updated"
    click_on "Back"
  end

  test "should destroy Appointment type" do
    visit appointment_type_url(@appointment_type)
    click_on "Destroy this appointment type", match: :first

    assert_text "Appointment type was successfully destroyed"
  end
end
