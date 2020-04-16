Rails.application.routes.draw do

  root :to => "home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets
  resources :users, :except => :new
  get "signup" => "users#new"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  post "likes/:tweet_id/create" => "likes#create"
  post "likes/:tweet_id/destroy" => "like#destroy"
  get "users/:id/likes" => "user#likes"
end

