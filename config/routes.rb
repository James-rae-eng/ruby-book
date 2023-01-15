Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  resources :friend_requests
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :posts
  
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root "posts#index"
  
end
