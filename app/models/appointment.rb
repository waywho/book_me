class Appointment < Event
  after_initialize :dup_from_appointment_type
  validates :creator_email, :creator_name, :start_at, presence: true

  def template_info
    {
      summary: title,
      description: "#{I18n.t(".shared.booking_via_fixr")}: #{self.description}"
    }
  end

  private

  def dup_from_appointment_type
    return unless appointment_type
    # I18n.t("appt_with_person", appt: appointment_type.title, person: self.creator_name)
    self.title = appointment_type.title
    self.description = appointment_type.description
    self.end_at = start_at + appointment_type.duration.minutes
    self.user = calendar.user
  end
end
