class AppointmentType < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :nullify
end
