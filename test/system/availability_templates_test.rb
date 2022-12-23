require "application_system_test_case"

class AvailabilityTemplatesTest < ApplicationSystemTestCase
  setup do
    @availability_template = availability_templates(:one)
  end

  test "visiting the index" do
    visit availability_templates_url
    assert_selector "h1", text: "Availability templates"
  end

  test "should create availability template" do
    visit availability_templates_url
    click_on "New availability template"

    fill_in "Appointment type", with: @availability_template.appointment_type_id
    fill_in "Calendar", with: @availability_template.calendar_id
    fill_in "Days ahead", with: @availability_template.days_ahead
    check "Indefinite" if @availability_template.indefinite
    fill_in "Title", with: @availability_template.title
    fill_in "User", with: @availability_template.user_id
    click_on "Create Availability template"

    assert_text "Availability template was successfully created"
    click_on "Back"
  end

  test "should update Availability template" do
    visit availability_template_url(@availability_template)
    click_on "Edit this availability template", match: :first

    fill_in "Appointment type", with: @availability_template.appointment_type_id
    fill_in "Calendar", with: @availability_template.calendar_id
    fill_in "Days ahead", with: @availability_template.days_ahead
    check "Indefinite" if @availability_template.indefinite
    fill_in "Title", with: @availability_template.title
    fill_in "User", with: @availability_template.user_id
    click_on "Update Availability template"

    assert_text "Availability template was successfully updated"
    click_on "Back"
  end

  test "should destroy Availability template" do
    visit availability_template_url(@availability_template)
    click_on "Destroy this availability template", match: :first

    assert_text "Availability template was successfully destroyed"
  end
end
