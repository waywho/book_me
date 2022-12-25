# frozen_string_literal: true

class StepIndicatorsComponentPreview < ViewComponent::Preview
  def default
    render(StepIndicatorsComponent.new([:first, :second, :next, :last], current_step: :next))
  end
end
