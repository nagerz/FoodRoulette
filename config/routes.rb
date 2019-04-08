Rails.application.routes.draw do
  root to: 'home#index'
  get '/login', to: 'login#index'
  get '/logout', to: 'sessions#destroy'
  get 'auth/google', as: :google_connect
  get 'auth/google/callback', to: 'sessions#create'
  get 'vote', to: 'votes#show'

  get '/roulette', to: 'roulette#show', as: :roulette
  get '/roulettes', to: 'roulette#index', as: :group_roulette
  get '/refine', to: 'refine#show'
  get '/about', to: 'about#show'
  resources :surveys, only: [:new, :show, :create, :update]
  post '/surveys/:id', to: 'surveys#end', as: :end_survey

  get '/directions', to: 'directions#show'

  resources :responses, only: [:create]

  get '/profile', to: 'users#show'
  mount ActionCable.server => '/cable'
end
