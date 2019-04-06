Rails.application.routes.draw do
  root to: 'home#index'
  get '/login', to: 'login#index'
  get '/logout', to: 'sessions#destroy'
  get 'auth/google', as: :google_connect
  get 'auth/google/callback', to: 'sessions#create'

  get '/roulette', to: 'roulette#show', as: :roulette
  get '/roulettes', to: 'roulette#index', as: :group_roulette
  get '/refine', to: 'refine#show'
  resources :survey, only: [:new, :show]
  get '/about', to: 'about#show'

  get '/profile', to: 'users#show'
end
