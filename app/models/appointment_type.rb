class AppointmentType < ApplicationRecord
  belongs_to :user
  has_many :calendar_appointment_types, dependent: :delete_all
  has_many :calendars, through: :calendar_appointment_types
  has_many :events, dependent: :nullify
end
