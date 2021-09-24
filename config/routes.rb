Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'

  get '/dashboard/:user_id', to: 'users#dashboard', as: '/dashboard'

  get '/profile/:user_id', to: 'users#profile', as: '/profile'
  get '/profile/:user_id/edit', to: 'users#edit', as: '/profile/edit'
  patch '/profile/:user_id', to: 'users#update', as: '/profile/update'
  post '/profile/:user_id', to: 'users#update'

  resources :friendships, only: [:create, :destroy]
  resources :events, only: [:create, :destroy, :new]
  resources :gyms, only: [:index, :show]
  resources :gym_memberships, only: [:create, :destroy]
end
