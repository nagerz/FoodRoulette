Rails.application.routes.draw do
  root to: 'home#index'
  get '/login', to: 'login#index'
  get '/logout', to: 'sessions#destroy'
  get 'auth/google', as: :google_connect
  get 'auth/google/callback', to: 'sessions#create'

  get '/roulette', to: 'roulette#show', as: :roulette
  get '/roulettes', to: 'roulette#index'
  get '/refine', to: 'refine#show'
  get '/survey', to: 'survey#show'
  get '/about', to: 'about#show'

  get '/profile', to: 'users#show'
end
