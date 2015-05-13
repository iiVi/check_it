Rails.application.routes.draw do

  root to: 'application#index'

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  get '/authfoursq' => 'users#authenticate_foursq'

  post '/listcheck' => 'users#address_check'

  get 'sessions/new' => 'sessions#new'
  post 'sessions' => 'sessions#create'
  delete 'sessions' => 'sessions#destroy'



end

