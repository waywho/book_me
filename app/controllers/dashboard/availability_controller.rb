class Dashboard::AvailabilityController < DashboardController
  include CalendarSetter

  before_action :set_appointment_type

  def index
    @availabilities = calendar_service.events(q: @appointment_type.availability_identifier)
  end

  def create
    availability_template = appointment_type.availability_template
    AddAvailabilityToGoolgeCalendarJob.perform_later(
      calendar_id: @calendar.id,
      availability_template_id: availability_template.id,
      user_id: current_user.id,
      test: true
    )
  end

  def insert_template
    AddAvailabilityToGoolgeCalendarJob.perform_later(
      calendar_id: @calendar.id,
      appointment_type: @appointment_type.id,
      user_id: current_user.id,
      test: true
    )

    redirect_to [:dashboard, :appointment_types, calendar_id: @calendar.id], notice: "Availability template for #{@appointment_type.title} will be shortly added to your calendar."
  end
end
