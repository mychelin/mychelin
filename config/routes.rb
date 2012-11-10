Mychelin::Application.routes.draw do
  get "service/list_restaurants"

  resources :restaurants

  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'

  get '/service/restaurants' => 'service#list_restaurants'
  get '/service/restaurant/:reference' => 'service#show_restaurant'
end
