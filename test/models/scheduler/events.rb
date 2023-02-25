require "test_helper"
require 'minitest/autorun'

class Scheduler::EventsTest < ActiveSupport::TestCase
  test "test scheduler with recurrance rule" do
    mock_event = OpenStruct.new(
      recurrence: ["RRULE:FREQ=WEEKLY;BYDAY=FR,MO,TH,TU,WE"],
      status: "confirmed"
    )

    scheduler = Scheduler::Events.schedule(mock_event)
    scheduled_days = scheduler.events.map { |e| I18n.l(e.start_date, format: :weekday) }.uniq

    assert scheduled_days.include?("Mon")
    assert_not scheduled_days.include?("Sat")
    assert_not scheduled_days.include?("Sun")
    assert_equal (Time.zone.now + 30.days).to_date, scheduler.events.last.start_date.to_date
  end
end
