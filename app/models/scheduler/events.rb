require 'ice_cube'
require 'ice_cube/time_util'
require 'active_support/time'

class Scheduler::Events
  attr_reader :recurring_event, :exdates, :schedule, :max_period

  DAYS = {
    'SU' => :sunday, 'MO' => :monday, 'TU' => :tuesday, 'WE' => :wednesday,
    'TH' => :thursday, 'FR' => :friday, 'SA' => :saturday
  }

  def self.schedule(recurring_event, exdates: nil)
    new(recurring_event, exdates: exdates)
  end

  # exdates - array of datetime
  def initialize(recurring_event, exdates: nil, max_period: 30)
    @recurring_event = recurring_event
    @rfc_rules = @recurring_event.recurrence.join("/n")
    @exdates = exdates
    @max_period = max_period

    @schedule = IceCube::Schedule.from_ical(@rfc_rules)
  end

  def events
    schedule.occurrences(max_period.days.from_now).each_with_object([]) do |date, arr|
      if !@exdates || @exdates.map(&:to_date).exclude?(date.to_date)
        arr << Events::RecurringEvent.new(
                event: @recurring_event,
                recurring_date: date
              )
      end
    end
  end
end
