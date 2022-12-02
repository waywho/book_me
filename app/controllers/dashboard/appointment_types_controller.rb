class Dashboard::AppointmentTypesController < ApplicationController
  before_action :set_calendar
  before_action :set_appointment_type, only: %i[ show edit update destroy ]

  # GET /dashboard/appointment_types
  def index
    @appointment_types = @calendar.appointment_types
  end

  # GET /dashboard/appointment_types/1
  def show
  end

  # GET /dashboard/appointment_types/new
  def new
    @appointment_type = @calendar.appointment_types.new
  end

  # GET /dashboard/appointment_types/1/edit
  def edit
  end

  # POST /dashboard/appointment_types
  def create
    @appointment_type = @calendar.appointment_types.new(appointment_type_params)

    if @appointment_type.save
      redirect_to [:dashboard, @appointment_type, calendar_id: @calendar.id], notice: "Appointment type was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dashboard/appointment_types/1
  def update
    if @appointment_type.update(appointment_type_params)
      redirect_to [:dashboard, @appointment_type, calendar_id: @calendar.id], notice: "Appointment type was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /dashboard/appointment_types/1
  def destroy
    @appointment_type.destroy
    redirect_to dashboard_appointment_types_path(calendar_id: @calendar.id), notice: "Appointment type was successfully destroyed."
  end

  private
    def set_calendar
      @calendar = Calendar.find(params[:calendar_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_appointment_type
      @appointment_type = @calendar.appointment_types.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_type_params
      params.require(:appointment_type).permit(:title, :description, :location, :duration, :user_id)
    end
end
