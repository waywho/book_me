class Dashboard::AppointmentTypesController < DashboardController
  before_action :set_appointment_type, only: %i[ show edit update destroy ]

  # GET /dashboard/appointment_types
  def index
    @appointment_types = Current.calendar.appointment_types
  end

  # GET /dashboard/appointment_types/1
  def show
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(:modal, partial: "dashboard/appointment_types/appointment_type_modal", locals: {appointment_type: @appointment_type} )
        ]
      end

      format.html { render :show }
    end
  end

  # GET /dashboard/appointment_types/new
  def new
    @appointment_type = Current.calendar.appointment_types.new
  end

  # POST /dashboard/appointment_types
  def create
     @appointment_type = Current.calendar.appointment_types.create(appointment_type_params.merge(user_id: current_user.id))

    if @appointment_type.persisted?
      AddAvailabilityToGoolgeCalendarJob.perform_later(
        calendar_id: Current.calendar.id,
        appointment_type_id: @appointment_type.id,
        user_id: current_user.id,
        test: true
      )

      turbo_responses = [
            turbo_stream.append(:appointment_types, partial: "dashboard/appointment_types/appointment_type", locals: { appointment_type: @appointment_type })]

      if current_user.reached_limit?
        turbo_responses << turbo_stream.remove(:new_appointment_type)
      else
        turbo_responses << turbo_stream.replace(:appointment_type_form, partial: "dashboard/appointment_types/form",
              locals: { appointment_type: AppointmentType.new } )
      end

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_responses
        end
        format.html { redirect_to [:dashboard, @appointment_type],
                      notice: "Appointment type was successfully created." }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(:appointment_type_form, partial: "dashboard/appointment_types/form",
              locals: { appointment_type: @appointment_type })
          ], status: :unprocessable_entity
        end

        format.html { redirect_to [:dashboard, @appointment_type, calendar_id: Current.calendar.id],
                      notice: "Appointment type was successfully created." }
      end
    end
  end

  # PATCH/PUT /dashboard/appointment_types/1
  def update
    if @appointment_type.update(appointment_type_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
          turbo_stream.replace(:appointment_type_form, partial: "dashboard/appointment_types/form",
              locals: { appointment_type: @appointment_type, calendar: Current.calendar })
          ]
        end
        format.html {
          redirect_to [:dashboard, @appointment_type], notice: "Appointment type was successfully updated."
        }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /dashboard/appointment_types/1
  def destroy
    @appointment_type.destroy
    redirect_to dashboard_appointment_types_path, notice: "Appointment type was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment_type
      @appointment_type = Current.calendar.appointment_types.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_type_params
      params.require(:appointment_type).permit(:title, :description, :location, :duration, :availability_identifier, :indefinite_booking,
        :days_ahead_booking, :pause)
    end
end
