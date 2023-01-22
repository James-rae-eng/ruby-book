Rails.application.routes.draw do

  resources :friendships
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :posts do
    resources :comments
  end
  
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy' 
    get "users/index" => "users#index"  #this is for the list of users
    get "users/show" => "users#show"  #this is for the friends list
  end

  root "posts#index"
  
end
