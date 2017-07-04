Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'

  get '/sign-up' => 'users#new', as: :new_user

  resource :users

end
