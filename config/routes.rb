require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users,:controllers => { :registrations => "users/registrations" }
  resources :tasks do
    member do
      post 'add_to_google_calendar'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get '/oauth2callback', to: 'tasks#oauth2callback'

  # Defines the root path route ("/")
  root "tasks#index"
  mount Sidekiq::Web => '/sidekiq'
end
