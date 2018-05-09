Rails.application.routes.draw do
  resources :profiles
  devise_for :users
  root 'home#welcome'

  get '/home', to: 'home#index'

  get '/verify', to: 'home#verify'
  patch '/verify', to: 'home#confirm_verify'
  delete '/verify', to: 'home#delete_verify'
end
