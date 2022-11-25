class Calendar < ApplicationRecord
  belongs_to :user

  def self.providers
    %w[ google_oauth2 ].freeze
  end

  validates :provider, inclusion: { in: providers }
end
