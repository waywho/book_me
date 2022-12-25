class Dashboard::DashboardWizardController <  DashboardController
  include Wicked::Wizard
  include Onboarding

  before_action :authenticate_user!
  skip_before_action :set_current_calendar

  steps :connect_calendar, :appointment_type, :set_availabilities, :retrieve_availabilities

  def show
    @user = current_user
    case step
    when :connect_calendar
      get_primary_calendar
      # skip_step if @connected_calendar
    when :appointment_type
      @calendar = current_user.calendars.first
      @appointment_type = @calendar.appointment_types.first || @calendar.appointment_types.new
    when :set_availabilities
      @calendar = current_user.calendars.first
      @appointment_type = @calendar.appointment_types.first
    when :retrieve_availabilities
      @calendar = current_user.calendars.first
      @appointment_type = @calendar.appointment_types.first
      @availabilities = calendar_service.events(q: @appointment_type.availability_identifier)
    end
    @calendar = current_user.calendars.first
    render_wizard
  end

  def update
    case step
    when :connect_calendar
      @calendar = find_or_create_calendar

      render_wizard @calendar
    when :appointment_type
      @calendar = current_user.calendars.first
      @appointment_type = @calendar.appointment_types.first

      if @appointment_type.persisted?
        @appointment_type.assign_attributes(appointment_type_param)
      else
        @appointment_type = @calendar.appointment_types.new(appointment_type_param)
      end

      render_wizard @appointment_type
      AddAvailabilityToGoolgeCalendarJob.perform_later(
        calendar_id: @calendar.id,
        appointment_type_id: @appointment_type.id,
        user_id: current_user.id,
        test: true
      )
    end
  end

  private

  def finish_wizard_path
    dashboard_calendar_path(calendar_id: @calendar.id)
  end

  def appointment_type_param
    params.require(:appointment_type).permit(:title, :description, :location,
      :duration, :availability_identifier, :indefinite_booking, :days_ahead_booking, :pause)
  end
end
