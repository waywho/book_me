Rails.application.routes.draw do
  devise_for :users
  get 'static_pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#index"
  #
  #
  Rails.application.routes.draw do
  devise_for :users
  get 'static_pages/index'
    if Rails.env.development?
      mount Lookbook::Engine, at: "/lookbook"
    end
  end
end
