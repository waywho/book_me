class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_calendar

  def set_current_calendar
    session[:calendar_id] = params[:calendar_id] if params[:calendar_id] && session[:calendar_id] != params[:calendar_id]

    Current.calendar ||= current_user.calendars.find(session[:calendar_id])
  end

   def calendar_service
    @calendar_service ||= Google::Calendar.new(user: current_user)
  end
end
