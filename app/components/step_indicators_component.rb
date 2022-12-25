# frozen_string_literal: true

class StepIndicatorsComponent < ViewComponent::Base
  def initialize(steps, current_step:)
    @current_step = current_step
    @steps = steps
    @current_step_count = @steps.index(@current_step)
  end

  def call
    content_tag :ul, class: "steps" do
      @steps.each_with_index do |step, index|
        concat tag.li(step.to_s.humanize(capitalize: false), class: "step #{'step-primary' if index <= @current_step_count}")
      end
    end
  end
end
