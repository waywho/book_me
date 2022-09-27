Rails.application.routes.draw do
  resources :calendars, only: %i[index show]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#index"

  # Routes for Google authentication
  match "auth/google_oauth2/callback", to: "oauth/google_auth#create", via: %i[get post]
  # get "auth/failure", to: redirect(‘/’)

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
end
