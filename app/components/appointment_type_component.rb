# frozen_string_literal: true

class AppointmentTypeComponent < ViewComponent::Base
  attr_reader :appointment_type

  def initialize(appointment_type, path: nil)
    @appointment_type = appointment_type
    @path = path || ""
  end
end
