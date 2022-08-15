Rails.application.routes.draw do
  # root to: 'samples#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  root to: 'posts#index'
  resources :posts
end
