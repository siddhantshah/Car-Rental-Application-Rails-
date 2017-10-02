Rails.application.routes.draw do
  resources :cars
  resources :rentals
  resources :superadmins
  resources :admins
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  # Search cars
  post '/list_cars' => 'cars#list_cars'
  get '/list_cars' => 'cars#list_cars'
  get '/search_cars' => 'cars#search_cars'
  post '/search_cars' => 'cars#search_cars'

  # post '/check_reserve_car' => 'rentals#check_reserve_car'
  get '/check_reserve_car' => 'rentals#check_reserve_car'
  post '/destroy_session' => 'sessions#destroy'

  # Reserve Car
  post '/reserve_car' => 'rentals#reserve_car'
  post '/car_reserved' => 'rentals#car_reserved'
  get '/reserve_car' => 'rentals#reserve_car'
  get '/car_reserved' => 'rentals#car_reserved'
  post '/reserve_in_db' => 'rentals#reserve_in_db'

  # Checkout History
  post '/checkout' => 'rentals#checkout'
  post '/checkout_history' => 'rentals#checkout_history'

  # Session
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'customers#new'
  post '/users' => 'customers#create'

  # Profiles
  post '/customer_profile' => 'customers#profile'
  get '/customer_profile' => 'customers#profile'
  post '/admin_profile' => 'admins#profile'
  get '/admin_profile' => 'admins#profile'
  post '/superadmin_profile' => 'superadmins#profile'
  get '/superadmin_profile' => 'superadmins#profile'
end
