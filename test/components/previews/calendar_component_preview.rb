# frozen_string_literal: true

class CalendarComponentPreview < ViewComponent::Preview
  def default
    render(CalendarComponent.new)
  end

  def availabilities
    dates = (Date.today..Date.tomorrow.end_of_month).to_a.sample(10)

    appointment_type = AppointmentType.new(
      title: "Flute Lesson",
      description: "Great Lesson to have",
      duration: 45
    )

    availabilities = dates.collect do |date|
      OpenStruct.new(
        title: "Best Appointment",
        start_at: Time.new(*date.to_s.split("-")).advance(hours: [9, 10, 8].sample),
        end_at: Time.new(*date.to_s.split("-")).advance(hours: [16, 17, 12].sample),
        start_date: date,
        end_date: date
      )
    end

    render(CalendarComponent.new(availabilities: availabilities, appt_type: appointment_type))
  end
end
