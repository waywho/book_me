# frozen_string_literal: true

class ModalComponentPreview < ViewComponent::Preview
  def default
  end

  def auto
  end

  def form
    appointment_type = AppointmentType.new(
      title: "Flute Lesson",
      description: "This is a great lesson",
      duration: 45,
      user: User.last
    )
    appointment = appointment_type.appointments.new(start_at: Time.now, end_at: Time.now.advance(minutes: appointment_type.duration))
    render_with_template(locals: {
      appointment: appointment
    })
  end
end
