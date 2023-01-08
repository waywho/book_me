class Appointment < Event
  after_initialize :dup_from_appointment_type
  validates :creator_email, :creator_name, presence: true

  private

  def dup_from_appointment_type
    return unless appointment_type

    self.title = appointment_type.title
    self.description = appointment_type.description
  end
end
