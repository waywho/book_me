class Event < ApplicationRecord
  acts_as_paranoid

  # Associations
  belongs_to :calendar
  belongs_to :user
  belongs_to :appointment_type, optional: true

    # Scopes
  scope :current, -> { order(start_at: :desc) }
end
