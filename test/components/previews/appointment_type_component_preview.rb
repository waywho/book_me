# frozen_string_literal: true

class AppointmentTypeComponentPreview < ViewComponent::Preview
  def default
    render(AppointmentTypeComponent.new(AppointmentType.last))
  end
end
