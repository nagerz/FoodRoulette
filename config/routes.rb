Rails.application.routes.draw do
  get '/recommendation', to: 'recommendations#show', as: :recommendation
  resources :recommendations, only: [:index]
end
