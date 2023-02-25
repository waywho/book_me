module Events
  class Base
    def event
      raise NotImplementedError
    end

    def title
      raise NotImplementedError
    end

    def creator_name
      raise NotImplementedError
    end

    def creator_email
      raise NotImplementedError
    end

    def start_at
      raise NotImplementedError
    end

    def end_at
      raise NotImplementedError
    end

    def start_date
      raise NotImplementedError
    end

    def end_date
      raise NotImplementedError
    end

    def description
      raise NotImplementedError
    end

    def location
      raise NotImplementedError
    end

    def time_zone
      raise NotImplementedError
    end
  end
end
