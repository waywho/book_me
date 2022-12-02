class Dashboard::CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_calendar, only: %i[ show edit update destroy ]
  before_action :set_calendar_service

  def index
    @external_calendars = @calendar_service.primary_calendar
    @calendars = current_user.calendars
  end

  # GET /user/calendars/1
  def show
  end

  # GET /user/calendars/1/edit
  def edit
  end

  # POST /user/calendars
  def create
    google_calendar = @calendar_service.get_calendar_list(params[:id])

    @calendar = current_user.calendars.where(identifier: google_calendar.id).first_or_create do |calendar|
      calendar.provider = "google_oauth2"
      calendar.identifier = google_calendar.id
      calendar.summary = google_calendar.summary
      calendar.description = google_calendar.description
      calendar.time_zone = google_calendar.time_zone
      calendar.primary = google_calendar.primary
      calendar.etag = google_calendar.etag.gsub("\"", "")
    end

    if @calendar.save
      redirect_to @calendar, notice: "Calendar was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user/calendars/1
  # def update
  #   if @calendar.update(calendar_params)
  #     redirect_to @calendar, notice: "Calendar was successfully updated."
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # DELETE /user/calendars/1
  def destroy
    @calendar.destroy
    redirect_to user_calendars_url, notice: "Calendar was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_service
      @calendar_service ||= Google::Calendar.new(user: current_user)
    end

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # # Only allow a list of trusted parameters through.
    # def calendar_params
    #   params.fetch(:user_calendar, {})
    # end
end
