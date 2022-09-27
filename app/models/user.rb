class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :google_token, ->{ where(service: 'google') }, class_name: "Token", autosave: true

  def self.from_omniauth(access_token, service: nil)
    where(email: access_token.info.email).first_or_initialize do |user|
      user.first_name = access_token.info.first_name,
      user.last_name = access_token.info.last_name,
      user.email = access_token.info.email
      user.external_auth = service
    end
  end

  def google_access_token
    #convenience method to retrieve the latest token and refresh if necessary
    t = google_token
    t.refresh! if t.expires_at < Time.now
    t.token
  end

  protected

  def password_required?
    external_auth.nil?
  end
end
