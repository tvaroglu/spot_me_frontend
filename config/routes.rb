Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/dashboard/:user_id', to: 'users#dashboard', as: '/dashboard'

  get '/profile/:user_id', to: 'users#profile', as: '/profile'
  get '/profile/:user_id/edit', to: 'users#edit', as: '/profile/edit'
  patch '/profile/:user_id', to: 'users#update', as: '/profile/update'
  post '/profile/:user_id', to: 'users#update'

  resources :events, only: [:create, :destroy, :new]
  resources :friendships, only: [:create, :destroy]
  resources :gym_memberships, only: [:create, :destroy]
  resources :gyms, only: [:index, :show]
  resources :registration, only: [:new, :create], controller: 'users'
end
