Rails.application.routes.draw do
  root to: 'home#index'
  get '/login', to: 'login#index'
  get '/logout', to: 'sessions#destroy'
  get 'auth/google', as: :google_connect
  get 'auth/google/callback', to: 'sessions#create'

  get '/roulette', to: 'roulette#show', as: :roulette
  get '/roulettes', to: 'roulette#index', as: :group_roulette

  get '/directions', to: 'directions#show'

  resources :surveys, only: [:new, :show, :create, :update]
  post '/surveys/:id/end', to: 'surveys#end', as: :end_survey
  post '/surveys/:id/cancel', to: 'surveys#cancel', as: :cancel_survey
  get '/vote/:id', to: 'surveys#vote', as: :vote

  resources :responses, only: [:create]

  get '/profile', to: 'users#show'

  get '/about', to: 'about#show'

  namespace :api do
    namespace :v1 do
      resources :surveys, only: :show do
      end
    end
  end
  # mount ActionCable.server => '/cable'
end
