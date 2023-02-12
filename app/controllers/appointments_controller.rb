class AppointmentsController < ApplicationController
  before_action :set_calendar
  before_action :set_appointment_type, except: :index

  def index
    @appointment_types = @calendar.appointment_types
  end

  def new
    @appointment = @calendar.appointments.new(appointment_type: @appointment_type, start_at: params[:start_at].to_datetime)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:modal, partial: "appointments/appointment_modal", locals: { appointment: @appointment })
      end
    end
  end

  def show
    if @appointment_type && !@appointment_type.pause?
      @availabilities = calendar_service.events(q: @appointment_type.availability_identifier)
    else
      render :appointment_not_availabile
    end
  end

  def create
    @appointment = @calendar.appointments.new({ appointment_type: @appointment_type }.merge(appointment_params))

    if @appointment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:modal_content, partial: "appointments/create", locals: { appointment: @appointment })
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:modal, partial: "appointments/appointment_modal", locals: { appointment: @appointment })
        end
      end
    end
  end

  private

  def set_appointment_type
    @appointment_type = @calendar.appointment_types.friendly.find(params[:id])
  end

  def set_calendar
    @calendar = Calendar.friendly.find(params[:calendar])
  end

  def calendar_service
    @calendar_service ||= Google::Calendar.new(user: @calendar.user)
  end

  def appointment_params
    params.require(:appointment).permit(:start_at, :creator_name, :creator_email)
  end
end
