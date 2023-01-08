# frozen_string_literal: true

class CalendarComponent < ViewComponent::Base
  attr_reader :time_zone, :current_date, :max_period, :end_booking_date, :availabilities, :appointment_type

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

  def initialize(current_date: nil, time_zone: nil, max_period: 30, availabilities: nil, appt_type: nil)
    @current_date = current_date || Time.now.in_time_zone(time_zone)
    @time_zone = time_zone
    @max_period = max_period
    @end_booking_date = @current_date + max_period.days
    @availabilities = availabilities
    @appointment_type = appt_type
  end

  def days
    (min_date..max_date).each_with_object([]) do |day, arr|
      arr << DayComponent.new(day, bookable: day > current_date && day < end_booking_date)
    end
  end

  def day_start
    availabilities.min_by { |a| a.start_at.hour }.start_at
  end

  def day_start_minutes
    (day_start - day_start.at_beginning_of_day) / 60
  end

  def day_end
    availabilities.max_by { |a| a.end_at.hour + 1 }.end_at
  end

  def availability_date(date)
    return unless availabilities

    availabilities.find { |a| a.start_date.to_date == date.to_date }
  end

  def availability_start_minutes(avail_date)
    (avail_date.start_at - avail_date.start_at.at_beginning_of_day) / 60
  end

  def current_month
    l current_beginning_of_week, format: :month
  end

  def availability_grid(availability_date)
    return [] unless availability_date && appointment_type

    row_num = (availability_date.end_at.hour + 1 - availability_date.start_at.hour) * 60 / appointment_type.duration

    row_start = (availability_start_minutes(availability_date) - day_start_minutes).to_i

    row_num.times.each_with_object([]) do |n, a|
      time = l availability_date.start_at.advance(minutes: (appointment_type.duration * n)), format: :short_time


      a << [row_start + (n * appointment_type.duration) + 1, time]
    end
  end

  def base_appointment_grid(with_availability_date = nil)
    return 1 unless with_availability_date && appointment_type

    (day_end.hour + 1 - day_start.hour) * 60
  end

  private

  def day_css(with_availability_date = nil)
    bg_css = (with_availability_date ? "bg-white grid" : "bg-slate-200")

    "row-start-4 rounded-lg h-[800px] #{bg_css} #{base_appointment_grid(with_availability_date)}"
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
