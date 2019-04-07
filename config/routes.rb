Rails.application.routes.draw do
  root to: 'home#index'
  get '/login', to: 'login#index'
  get '/logout', to: 'sessions#destroy'
  get 'auth/google', as: :google_connect
  get 'auth/google/callback', to: 'sessions#create'

  get '/roulette', to: 'roulette#show', as: :roulette
  get '/roulettes', to: 'roulette#index', as: :group_roulette
  get '/refine', to: 'refine#show'
  get '/about', to: 'about#show'
  resources :surveys, only: [:new, :show, :create]
  post 'twilio/status', to: 'twilio_text_messenger#status'

  get '/profile', to: 'users#show'
  mount ActionCable.server => '/cable'
end
