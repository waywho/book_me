# frozen_string_literal: true

class CalendarComponent < ViewComponent::Base
  attr_reader :time_zone, :current_date, :max_period, :end_booking_date, :availabilities, :appointment_type, :busy

    class DayComponent < ViewComponent::Base
      attr_reader :weekday, :date, :month, :year, :full_date,
                  :bookable

      def initialize(date, bookable: true)
        @full_date = date
        @weekday = l(date, format: :weekday)
        @date = l(date, format: :date)
        @month = l(date, format: :month)
        @year = l(date, format: :year)
        @bookable = bookable
      end
    end

    class Availability
      attr_reader :start_at, :end_at

      def initialize(start_at:, end_at:)
        @start_at = start_at
        @end_at = end_at
      end
    end

  def initialize(current_date: nil, time_zone: nil, max_period: 30, availabilities: nil,
                 busy: nil, appt_type: nil, new_appointment_url: "")
    @current_date = current_date || Time.now.in_time_zone(time_zone)
    @time_zone = time_zone
    @max_period = max_period
    @end_booking_date = @current_date + max_period.days
    @availabilities = availabilities
    @appointment_type = appt_type
    @new_appointment_url = new_appointment_url
    @busy = busy
  end

  def days
    (min_date..max_date).each_with_object([]) do |day, arr|
      arr << DayComponent.new(day, bookable: day > current_date && day < end_booking_date)
    end
  end

  def availibilities_start_at
    availabilities.min_by { |a| a.start_at.hour }.start_at
  end

  def availibilities_start_minutes
    (availibilities_start_at.to_i - availibilities_start_at.at_beginning_of_day.to_i) / 60
  end

  def availabilities_end_at
    availabilities.max_by { |a| a.end_at.hour + 1 }.end_at
  end

  def availability_slots_by(date)
    return unless availabilities

    availabilities.select { |a| a.start_date == date }
  end

  def start_minutes_by(availability)
    (availability.start_at.to_i - availability.start_at.at_beginning_of_day.to_i) / 60
  end

  def current_month
    l current_beginning_of_week, format: :month
  end

  def busy_events_by(date)
    return unless busy

    busy.select { |b| b.start_date.to_date == date.to_date }
  end

  def availability_grid(date)
    return [] unless date && appointment_type

    availability_slots = availability_slots_by(date)
    return [] if availability_slots.blank?

    busy_events = busy_events_by(date)

    build_availability_day(availability_slots, busy_events).map do |slot|
      row_start = start_minutes_by(slot) - availibilities_start_minutes

      # subtracting two datetime returns fraction of a day
      row_num = ((slot.end_at.to_f - slot.start_at.to_f) / (60 * appointment_type.duration)).to_i

      row_num.times.each_with_object([]) do |n, a|
        a << {
          row_ordinal: row_start + (n * appointment_type.duration) + 1,
          start_at: slot.start_at.advance(minutes: (appointment_type.duration * n)),
          end_at: slot.start_at.advance(minutes: (appointment_type.duration * (n + 1)) - 1)
        }
      end
    end.flatten(1)
  end

  def base_calendar_grid(with_availability_date = false)
    return 1 unless with_availability_date && appointment_type

    (availabilities_end_at.hour + 1 - availibilities_start_at.hour) * 60
  end

  private

  def build_availability_day(availabilities, busy_events)
    return availabilities if busy_events.blank?

    sorted_busy_events = busy_events.sort_by(&:start_at)

    availabilities.each_with_object([]) do |availability, new_avails|
      new_avails << build_availabity_slots(availability, sorted_busy_events)
    end.flatten
  end

  def build_availabity_slots(availability, busy_events)
    avails = []
    busy_event = busy_events.first

    return [availability] if busy_event.nil?

    if busy_event.end_at > availability.start_at && busy_event.end_at < availability.end_at
      if availability.start_at <= busy_event.start_at
        avails << Availability.new(start_at: availability.start_at,
                                   end_at: busy_event.start_at)
        avails << build_availabity_slots(Availability.new(start_at: busy_event.end_at,
                                   end_at: availability.end_at), busy_events.drop(1))
      else
        avails << build_availabity_slots(Availability.new(start_at: busy_event.end_at,
                                   end_at: availability.end_at), busy_events.drop(1))
      end
    elsif busy_event.end_at > availability.end_at
      if busy_event.start_at > availability.start_at && busy_event.start_at < availability.end_at
        avails << Availability.new(start_at: availability.start_at,
                                   end_at: busy_event.start_at)
      end
    elsif busy_event.end_at < availability.start_at
      avails << build_availabity_slots(Availability.new(start_at: availability.start_at,
                                   end_at: availability.end_at), busy_events.drop(1))
    end

    avails
  end

  def slot_label(datetime)
    l datetime, format: :short_time
  end

  def appointment_link(start_at)
    return @new_appointment_url if @new_appointment_url.blank?

    url = Addressable::URI.parse(@new_appointment_url)
    url.query_values = (url.query_values || {}).merge({
      start_at: start_at
    })

    url.to_s
  end

  def day_css(with_availability_date = false)
    bg_css = (with_availability_date ? "bg-white grid" : "bg-slate-200")

    "row-start-4 rounded-lg h-[800px] #{bg_css} #{base_calendar_grid(with_availability_date)}"
  end

  def min_date
    current_date.at_beginning_of_week.to_date
  end

  def max_date
    end_booking_date.at_end_of_week.to_date
  end

  def year_row(week)
    i = week.find_index { |d| d.year != week[0].year }
    r = [[0, i || 7]]
    r << [i, 7] if i
    r
  end

  def month_row(week)
    i = week.find_index { |d| d.month != week[0].month }
    r = [[0, i || 7]]
    r << [i, 7] if i
    r
  end
end
