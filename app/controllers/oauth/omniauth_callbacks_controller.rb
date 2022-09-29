class Oauth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    access_auth = request.env["omniauth.auth"]

    @user = User.from_omniauth(access_auth)

    token_attributes = {
      token: access_auth.credentials.token,
      refresh_token: access_auth.credentials.refresh_token,
      provider: access_auth.provider,
      expires_at: Time.zone.at(access_auth.credentials.expires_at)
    }

    if @user.google_token.present?
      @user.google_token.update(token_attributes)
    else
      @user.build_google_token(token_attributes)
    end

    @user.save!

    if @user.persisted?
      sign_in(:user, @user)
      redirect_to google_calendars_path
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_oauth2_data"] = access_auth.except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
