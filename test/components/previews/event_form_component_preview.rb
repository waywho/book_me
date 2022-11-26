# frozen_string_literal: true

class EventFormComponentPreview < ViewComponent::Preview
  def default
    render(EventFormComponent.new(event: :event, path: "/"))
  end
end
