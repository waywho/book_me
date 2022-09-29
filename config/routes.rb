Rails.application.routes.draw do
  namespace :google do
    resources :calendars, only: %i[index show create]
  end
  devise_for :users, controllers: { omniauth_callbacks: 'oauth/omniauth_callbacks' } do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#index"

  # Routes for Google authentication
  # match "auth/google_oauth2/callback", to: "oauth/google_auth#create", via: %i[get post]
  # get "auth/failure", to: redirect(‘/’)

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
end
