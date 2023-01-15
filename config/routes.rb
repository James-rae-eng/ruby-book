Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :posts
  
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root "posts#index"
  
end
