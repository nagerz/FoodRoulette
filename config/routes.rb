Rails.application.routes.draw do
  get '/restaurant', to: 'restaurants#show', as: :restaurant
  resources :restaurants, only: [:index]
end
