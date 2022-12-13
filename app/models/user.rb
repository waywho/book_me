class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_one :google_token, ->{ where(provider: 'google_oauth2') },
          class_name: "Token", autosave: true, dependent: :delete
  has_many :calendars
  has_many :appointment_types

  def self.from_omniauth(auth)
    where(email: auth.info.email, provider: auth.provider).first_or_initialize do |user|
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.zone.now
    end
  end

  def google_access_token
    #convenience method to retrieve the latest token and refresh if necessary
    t = google_token
    t.refresh! if t.expires_at < Time.zone.now
    t.token
  end

  def reached_limit?
    return false if premium?

    appointment_types.one?
  end

  def premium?
    false
  end
end
