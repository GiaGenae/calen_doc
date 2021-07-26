Rails.application.routes.draw do

  root 'sessions#welcome'
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#create'
  
  resources :users
  resources :reviews
  resources :appointments
  resources :doctors, only: [:index]
  resources :doctors do
    resources :reviews, only:[:new, :index]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end