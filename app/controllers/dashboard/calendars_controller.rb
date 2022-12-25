class Dashboard::CalendarsController < DashboardController
  include Onboarding

  before_action :authenticate_user!
  skip_before_action :set_current_calendar, only: :index

  def index
    get_primary_calendar
  end

  # GET /user/calendars/1
  def show
    @appointment_type = Current.calendar.appointment_types.first
  end

  # POST /user/calendars
  def create
    @calendar = find_or_create_calendar

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
