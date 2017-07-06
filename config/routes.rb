Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'


  get '/login' => 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout' =>'sessions#destroy'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/dashboard' => 'users#dashboard', as: :dashboard

  resources :users

end
