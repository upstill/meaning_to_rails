Rails.application.routes.draw do
  use_doorkeeper

  namespace 'api', defaults: { format: 'json' } do
    namespace 'v1' do
      resources :list_types do
        resources :list_items
      end
      resources :list_items
    end
  end
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'sign_in'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions
  resources :list_types do 
    resources :list_items
  end
  resources :list_items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#root'

  get 'auth/:provider/callback', to: 'sessions#create'
  post 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  resources :identities

end
