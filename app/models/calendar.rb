class Calendar < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :appointment_types
  has_many :availabilities

  def self.providers
    %w[ google_oauth2 ].freeze
  end

  validates :provider, inclusion: { in: providers }
end
