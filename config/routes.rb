Rails.application.routes.draw do
  root to: 'home#index'
  get '/login', to: 'login#index'
  get 'auth/google', as: :google_connect
  get 'auth/google/callback',  to: 'sessions#create'

  get '/restaurant', to: 'restaurants#show', as: :restaurant
  get '/refine', to: 'refine#show', as: :refine
  get '/survey', to: 'survey#show', as: :survey
  get '/about', to: 'about#show', as: :about

  get '/profile', to: 'users#show', as: :profile

  resources :restaurants, only: [:index]
end
