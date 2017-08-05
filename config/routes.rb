Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations', :omniauth_callbacks => 'users/omniauth_callbacks' }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
  get '/terms-of-service' => 'static_pages#terms_of_service', as: :terms_of_service
  get '/privacy-policy' => 'static_pages#privacy_policy', as: :privacy_policy

  get '/help' => 'static_pages#help', as: :help


  get '/dashboard' => 'users#dashboard', as: :dashboard
  get '/schedule_time' => 'users#schedule_time'

  get '/edit_profile' => 'users#edit', as: :edit_profile  #for non-sensitive editing (not email/password)
  patch '/user' => 'users#update', as: :user

  get '/meetings/new/:id' => 'meetings#new', as: :new_meeting
  post '/meetings' => 'meetings#create'
  get '/account_setup' => 'users#account_setup', as: :account_setup

  get '/meetings/confirm_meeting/:id' => 'meetings#confirm_meeting', as: :confirm_meeting

  resources :change_requests,     only: [:new, :create]
  resources :invites,             only: [:new, :create]

  get '/error' => 'static_pages#error'

end
