Rails.application.routes.draw do
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  namespace :dashboard do
    resources :appointments, only: :show
    get :onboarding, to: 'dashboard_wizard#show'
    put :onboarding, to: 'dashboard_wizard#update'
    get "/", to: "calendars#index"
    resource :calendar, only: %i[ index show create destroy ]
    scope "calendar/" do
      resources :appointment_types, except: :edit do
        get :availabilities, to: "availabilities#index"
        get :insert_availability_template, to: "availabilities#insert_template"
      end
    end
  end

  scope "/:calendar" do
    get "/", to: "calendar#index", as: :calendars
    resources :calendar, only: [:show]
    resources :appointments, except: :index
  end

  resources :calendar

  devise_for :users, controllers: { omniauth_callbacks: 'oauth/omniauth_callbacks' } do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#index"

  # Routes for Google authentication
  # match "auth/google_oauth2/callback", to: "oauth/google_auth#create", via: %i[get post]
  # get "auth/failure", to: redirect(‘/’)
end
