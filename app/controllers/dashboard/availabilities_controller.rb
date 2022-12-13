class Dashboard::AvailabilitiesController < ApplicationController
  before_action :set_calendar
  before_action :set_availability, only: %i[ show edit update destroy ]

  # GET /dashboard/availabilities
  def index
    @availabilities = @calendar.availabilities.all
  end

  # GET /dashboard/availabilities/1
  def show
  end

  # GET /dashboard/availabilities/new
  def new
    @availability = @calendar.availabilities.new
  end

  # GET /dashboard/availabilities/1/edit
  def edit
  end

  # POST /dashboard/availabilities
  def create
    @availability = @calendar.availabilities.new(availability_params)

    if @availability.save
      redirect_to [:dashboard, @availability], notice: "Availability was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dashboard/availabilities/1
  def update
    if @availability.update(availability_params)
      redirect_to [:dashboard, @availability], notice: "Availability was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /dashboard/availabilities/1
  def destroy
    @availability.destroy
    redirect_to dashboard_availabilities_url, notice: "Availability was successfully destroyed."
  end

  private
   def set_calendar
      @calendar = Calendar.find(params[:calendar_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = @calendar.availabilities.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def availability_params
      params.fetch(:availability, {})
    end
end
