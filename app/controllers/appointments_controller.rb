class AppointmentsController < ApplicationController
  def index

  end

  private

  def set_calendar
    @calendar = Calendar.friendly.find(params[:calendar_id])
  end
end
