class Calendar < ApplicationRecord
  belongs_to :user
  has_many :calendar_appointment_types
  has_many :appointment_types, through: :calendar_appointment_types

  def self.providers
    %w[ google_oauth2 ].freeze
  end

  validates :provider, inclusion: { in: providers }
end
