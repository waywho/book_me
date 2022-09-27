require 'google/api_client/client_secrets.rb'

class Token < ApplicationRecord
  # constants
  def self.auth_services
    %w[google].freeze
  end

  belongs_to :user
  validates :service, inclusion: { in: auth_services }

  def google_secret
    Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => token,
        "refresh_token" => refresh_token,
        "client_id"     => Rails.application.credentials.google.client_id,
        "client_secret" => Rails.application.credentials.google.client_secret
      }
    })
  end

  def refresh!
    response = google_secret.to_authorization.refresh!

    update(
      token: response["access_token"],
      expires_at: Time.now + response['expires_in'].to_i.seconds
    )
  end

  def expired?
    expires_at <= Time.now
  end
end
