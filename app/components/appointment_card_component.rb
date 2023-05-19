# frozen_string_literal: true

class AppointmentCardComponent < ViewComponent::Base
  attr_reader :appointment, :calendar

  def initialize(appointment:, title: nil, with: :booker, width: :card)
    @appointment = appointment
    @title = title
    @calendar = @appointment.calendar
    @with = with
    @width = width
  end

  def title
    return @title if @title

    person_name = case
    when :booker
      appointment.creator_name
    when :calendar_owner
      calendar.user.full_name
    else
      calendar.user.full_name
    end

    t(".appt_with_person", appt: @appointment.title, person: person_name)
  end

  private

  def wrapper_classes
    "card #{width} bg-slate-200 shadow-xl mx-auto mb-2"
  end

  def width
    case @width
    when :full
      "w-full"
    else
      "w-96"
    end
  end
end
