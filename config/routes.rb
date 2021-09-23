Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  # http://localhost:3000/auth/google_oauth2/callback
  # get '/auth/google_oauth2', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'
  get '/dashboard/:user_id', to: 'users#dashboard', as: '/dashboard'
  get '/profile/:user_id', to: 'users#profile', as: '/profile'
  post '/profile/:user_id', to: 'users#update'

  get '/users/:user_id/add_friend/:followee_id', to: 'friendships#create'

  resources :events, only: [:create, :destroy, :new]
  resources :gyms, only: [:index, :show, :create, :destroy], controller: :gyms
end
