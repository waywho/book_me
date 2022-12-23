class Dashboard::CalendarsController < DashboardController
  before_action :authenticate_user!
  skip_before_action :set_current_calendar, only: :index

  def index
    @external_calendar = calendar_service.primary_calendar
    calendars = current_user.calendars
    @connected_calendar = calendars.find_by(identifier: @external_calendar.id)
  end

  # GET /user/calendars/1
  def show
    @appointment_type = Current.calendar.appointment_types.first
  end

  # POST /user/calendars
  def create
    google_calendar = calendar_service.get_calendar_list(params[:id])

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
    Current.calendar.destroy
    redirect_to user_calendars_url, notice: "Calendar was successfully destroyed."
  end
end
