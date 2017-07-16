Rails.application.routes.draw do
  get 'change_requests/new'

  get 'change_requests/create'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'


  get '/login' => 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout' =>'sessions#destroy'


  get '/signup' => 'users#new'
  # post '/signup' => 'users#create'

  get '/dashboard' => 'users#dashboard', as: :dashboard
  get '/schedule_time' => 'users#schedule_time'
  patch '/update_ga' => 'users#update_ga'
  get '/edit_profile' => 'users#edit', as: :edit_profile

  get '/meetings/new/:id' => 'meetings#new', as: :new_meeting
  post '/meetings' => 'meetings#create'
  get '/account_setup' => 'users#account_setup', as: :account_setup

  get '/meetings/confirmation/:id' => 'meetings#confirmation', as: :confirmation

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :change_requests,     only: [:new, :create]
  resources :invites,             only: [:new, :create]

end
