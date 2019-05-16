Rails.application.routes.draw do
  use_doorkeeper

  namespace 'api' do
    namespace 'v1' do
      resources :list_types
      resources :list_items
    end
  end
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'sign_in'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions
  resources :list_types
  resources :list_items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'list_items#index'
end
