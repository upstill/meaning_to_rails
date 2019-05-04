Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions
  use_doorkeeper
  resources :list_types
  resources :list_items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'list_items#index'
end
