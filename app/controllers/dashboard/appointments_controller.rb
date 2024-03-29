class Dashboard::AppointmentsController < DashboardController
  skip_before_action :set_current_calendar

  def index
    @appointments = current_user.appointments.current
  end

  def show
    @appointment = current_user.appointments.find(params[:id])
  end
end
