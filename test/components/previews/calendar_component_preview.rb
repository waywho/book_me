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

  def availabilities_busy
    dates = (Date.today..Date.tomorrow.end_of_month).to_a.sample(10)

    appointment_type = AppointmentType.new(
      title: "Flute Lesson",
      description: "Great Lesson to have",
      duration: 45
    )

    events = dates.each_with_object({ availabilities: [], busy: [] }) do |date, h|
      h[:availabilities] << OpenStruct.new(title: "Best Appointment",
                                          start_at: Time.new(*date.to_s.split("-")).advance(hours: [9, 10, 8].sample),
                                          end_at: Time.new(*date.to_s.split("-")).advance(hours: [16, 17, 12].sample),
                                          start_date: date,
                                          end_date: date)

      busy_start = Time.new(*date.to_s.split("-")).advance(hours: (9..17).to_a.sample)

      h[:busy] << OpenStruct.new(title: "Best Appointment",
                                 start_at: busy_start,
                                 end_at: busy_start.advance(minutes: [30, 45, 60].sample),
                                 start_date: date,
                                 end_date: date)
    end


    render(CalendarComponent.new(availabilities: events[:availabilities], appt_type: appointment_type, busy: events[:busy]))
  end
end
