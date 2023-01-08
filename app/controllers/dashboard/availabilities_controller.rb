class Dashboard::AvailabilitiesController < DashboardController
  include CalendarSetter

  before_action :set_appointment_type

  def index
    @availabilities = calendar_service.events(q: @appointment_type.availability_identifier)
  end

  def create

  end

  def insert_template
    AddAvailabilityToGoolgeCalendarJob.perform_later(
      calendar_id: @appointment_type.calendar.id,
      appointment_type: @appointment_type.id,
      user_id: current_user.id,
      test: true
    )

    respond_to do |format|
      format.html { redirect_to [:dashboard, :appointment_types, calendar_id: @calendar.id], notice: "Availability template for #{@appointment_type.title} will be shortly added to your calendar." }
    end
  end
end
