class CalendarAppointmentType < ApplicationRecord
  belongs_to :calendar
  belongs_to :appointment_type
end
