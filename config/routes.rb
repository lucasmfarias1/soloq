Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get '/verify', to: 'home#verify'
  patch '/verify', to: 'home#confirm_verify'
  delete '/verify', to: 'home#delete_verify'

  resources :profile
  # patch '/profile', to: 'profile#edit'

  get '/users/:id', :to => 'users#show', :as => :user
  patch '/users/:id', to: 'profile#update'
end
