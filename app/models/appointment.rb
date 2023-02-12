class Appointment < Event
  after_initialize :dup_from_appointment_type
  validates :creator_email, :creator_name, :start_at, presence: true

  private

  def dup_from_appointment_type
    return unless appointment_type

    self.title = appointment_type.title
    self.description = appointment_type.description
    self.end_at = start_at + appointment_type.duration.minutes
  end
end
