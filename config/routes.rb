Rails.application.routes.draw do

  root to: 'home#index'
  get '/login', to: 'login#index'
  get 'auth/google', as: :google_connect
  get 'auth/google/callback',  to: 'sessions#create'
end
