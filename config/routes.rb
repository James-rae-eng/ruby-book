Rails.application.routes.draw do
   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :posts do
    resources :comments
  end
  
  devise_for :users, :controllers => { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do 
    resources :friend_requests
    resources :friendships
    resources :likes, only: %i[create destroy]
  end

  root "posts#index"
  
end
