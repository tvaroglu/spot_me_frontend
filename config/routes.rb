Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/dashboard/:user_id', to: 'users#dashboard', as: '/dashboard'


  resources :events, only: [:create, :destroy, :new]
  resources :friendships, only: [:create, :destroy]
  resources :gym_memberships, only: [:create, :destroy]
  resources :gyms, only: [:index, :show]
  resources :profile, only: [:edit, :show, :update], controller: 'users'
  resources :registration, only: [:new, :create], controller: 'users'
end
