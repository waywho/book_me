class Calendar < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :appointment_types
  has_many :availability_templates
  has_many :appointments

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  attribute :premium_user_name

  def self.providers
    %w[ google_oauth2 ].freeze
  end

  validates :provider, inclusion: { in: providers }

  private

  def slug_candidates
   return premium_user_name if user.premium? && premium_user_name.present?
    [
      "#{user.first_name}#{user.last_name}",
      "#{user.first_name} #{user.last_name}"
    ]
  end
end
