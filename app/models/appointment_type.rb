class AppointmentType < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :calendars
  has_many :events, dependent: :nullify

  validate :user_limits, on: :create
  validates :title, presence: true
  validates :duration, numericality: true, presence: true

  private

  def user_limits
    return if user.nil? || user.premium?

    errors.add(:base, :exceed_allowed_number) if user.appointment_types.size >= 1
  end
end
