class AppointmentsController < ApplicationController
  include PublicCalendarSetter
  before_action :set_calendar
  before_action :set_appointment_type, except: %i[index show destroy]

  def index
    @appointment_types = @calendar.appointment_types
  end

  def new
    @appointment = @calendar.appointments.new(appointment_type: @appointment_type,
                                              start_at: params[:start_at].to_datetime)

    # TODO: reload window if the time is before Time.zone.now
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:modal,
            partial: "appointments/appointment_modal",
            locals: { appointment: @appointment })
      end
    end
  end

  def show
    @appointment = @calendar.appointments.find(params[:id])
    @appointment_type = @appointment.appointment_type

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t(".no_appointment")
    redirect_to calendars_path(calendar: @calendar) and return
  end

  def create
    @appointment = @calendar.appointments.new({ appointment_type: @appointment_type,
                                                user_id: @calendar.user.id }.merge(appointment_params))

    if calendar_service.add_appointment(@appointment) && @appointment.save
      CalendarNotificationMailer.with(appointment_id: @appointment.id).new_appointment.deliver_later
      BookingNotificationMailer.with(appointment_id: @appointment.id).confirm_appointment.deliver_later

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:modal_content, partial: "appointments/create", locals: { appointment: @appointment })
        end

        format.html { redirect_to appointment_redirect_path(@appointment) }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:modal, partial: "appointments/appointment_modal", locals: { appointment: @appointment })
        end

        format.html { render :show }
      end
    end
  end

  def destroy
    @appointment = @calendar.appointments.find(params[:id])

    if calendar_service.cancel_appointment(@appointment) && @appointment.destroy
      CalendarNotificationMailer.with(appointment_id: @appointment.id).cancelled_appointment.deliver_later
      BookingNotificationMailer.with(appointment_id: @appointment.id).cancelled_appointment.deliver_later

      flash[:notice] = t(".appointment_removed")
      redirect_to calendars_path(calendar: @calendar) and return
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:start_at, :creator_name, :creator_email)
  end

  def appointment_redirect_path(appointment)
    appointment_path(appointment, calendar: @calendar)
  end
end
