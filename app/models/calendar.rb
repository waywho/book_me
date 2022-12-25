class Calendar < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :appointment_types
  has_many :availability_templates

  after_initialize :create_external_identifier
  before_validation :create_external_identifier

  def self.providers
    %w[ google_oauth2 ].freeze
  end

  validates :provider, inclusion: { in: providers }
  validates :external_identifier, uniqueness: true, presence: true

  private

  # allow premium user to enter their own external identifier
  def create_external_identifier
    return if user.premium?
    return if persisted?

    "#{user.first_name}#{user.last_name}".downcase
  end
end
