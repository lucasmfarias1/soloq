Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get '/verify', to: 'home#verify'
  patch '/verify', to: 'home#confirm_verify'
  delete '/verify', to: 'home#delete_verify'
end
