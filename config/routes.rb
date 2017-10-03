Rails.application.routes.draw do
  resources :suggestions
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

  # Reserve Car
  get '/check_reserve_car' => 'rentals#check_reserve_car'
  # post '/check_reserve_car' => 'rentals#check_reserve_car'
  post '/reserve_car' => 'rentals#reserve_car'
  post '/car_reserved' => 'rentals#car_reserved'
  get '/reserve_car' => 'rentals#reserve_car'
  get '/car_reserved' => 'rentals#car_reserved'
  post '/reserve_in_db' => 'rentals#reserve_in_db'

  # Rental
  post '/return' => 'rentals#return'
  post '/checkout' => 'rentals#checkout'
  post '/checkout_history' => 'rentals#checkout_history'
  post '/notify_email' => 'customers#notify_email'

  # Session
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'customers#new'
  post '/users' => 'customers#create'
  post '/destroy_session' => 'sessions#destroy'

  # Profiles
  post '/customer_profile' => 'customers#profile'
  get '/customer_profile' => 'customers#profile'
  post '/admin_profile' => 'admins#profile'
  get '/admin_profile' => 'admins#profile'
  post '/superadmin_profile' => 'superadmins#profile'
  get '/superadmin_profile' => 'superadmins#profile'

  #Bonus Credit
  # post '/suggest_car' => 'cars#suggest_car'
  # post '/suggestions' => 'cars#suggestions'
  # post '/accept_suggestion' => 'suggestions#accept'
  # post '/view_suggestions' => 'suggestions#view_suggestions'

  post '/accept_suggestion' => 'suggestions#accept_suggestion'
  get '/accept_suggestion' => 'suggestions#accept_suggestion'
  get '/view_suggestions' => 'suggestions#view_suggestions'
  post '/accept_in_db' => 'suggestions#accept_in_db'

end
