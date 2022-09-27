class Oauth::GoogleAuthController < ApplicationController
  def create
    access_token = request.env["omniauth.auth"]

    user = User.from_omniauth(access_token, service: 'google')

    token_attributes = {
      token: access_token.credentials.token,
      refresh_token: access_token.credentials.refresh_token,
      service: "google",
      expires_at: Time.at(access_token.credentials.expires_at)
    }
    if user.google_token.present?
      user.google_token.update(token_attributes)
    else
      user.build_google_token(token_attributes)
    end

    user.skip_confirmation!
    user.save!
    sign_in(:user, user)
    redirect_to root_path
  end
end
