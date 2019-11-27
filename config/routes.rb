Rails.application.routes.draw do

  get 'bookings/index'
  get 'bookings/show'
  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/edit'
  get 'bookings/update'
  get 'bookings/destroy'
  devise_for :users
  root to: 'pages#home'

  resources :places

  resources :cards

  resources :experiences, only: [:index, :show]

  resources :users, only: [:show, :edit, :update]

  resources :bookings

  resources :categories, only: [:index]

  get "/fetch_experiences" => 'experiences#from_category', as: 'fetch_experiences'

end
