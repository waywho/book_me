class Availability < ApplicationRecord
  belongs_to :user
  belongs_to :calendar
  belongs_to :appointment_type
end
