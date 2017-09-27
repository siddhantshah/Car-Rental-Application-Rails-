Rails.application.routes.draw do
  resources :cars
  resources :rentals
  resources :superadmins
  resources :admins
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  post '/list_cars' => 'cars#list_cars'
  post '/search_cars' => 'customers#search_cars'
  post '/show_profile' => 'customers#show_profile'
  get '/show_profile' => 'customers#show_profile'
  # post '/check_reserve_car' => 'rentals#check_reserve_car'
  get '/check_reserve_car' => 'rentals#check_reserve_car'

  post '/reserve_car' => 'rentals#reserve_car'
  post '/car_reserved' => 'rentals#car_reserved'
  get '/reserve_car' => 'rentals#reserve_car'
  get '/car_reserved' => 'rentals#car_reserved'

  post '/reserve_in_db' => 'rentals#reserve_in_db'
  post '/checkout' => 'rentals#checkout'
  post '/checkout_history' => 'rentals#checkout_history'

  # SESSION

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'customers#new'
  post '/users' => 'customers#create'




end
