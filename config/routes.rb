Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'

  post '/login', to: 'sessions#create'

end
