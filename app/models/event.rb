class Event < ApplicationRecord
  belongs_to :calendar
  belongs_to :user
  belongs_to :appointment_type, optional: true
end
