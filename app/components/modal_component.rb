# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  renders_many :buttons, types: {
    delete: lambda { |**args|
      ButtonComponent.new(type: "btn-error", action: :delete, **args)
    },
    alert: lambda { |**args|
      ButtonComponent.new(type: "btn-error", **args)
    },
    primary: lambda { |**args|
      ButtonComponent.new(type: "btn-primary", **args)
    }
  }

  class ButtonComponent < ViewComponent::Base
    def initialize(type: 'primary', path: nil, action: nil)
      @type = type
      @path = path
      @action = action
    end

    def call
      if @action == :delete
        button_to content, @path, class: "btn #{@type}", method: :delete
      else
        link_to content, @path, class: "btn #{@type}"
      end
    end
  end

  def initialize(auto: false)
    @auto = auto
  end
end
