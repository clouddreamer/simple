Simple::Application.routes.draw do
  root to: "static_pages#home"

  

  resources :users do
collection { get "search"}
    
    member do
      get :following, :followers
    end
    
    end
  
  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
 
  
  #resources :users do
  #  collection { get "search"}  
  #end

  
  resources :users 
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy, :search, :index]
  resources :relationships, only: [:create, :destroy]
  resources :microposts do
    collection { get "search" }
  end

 
  match '/all', to:'users#all'
  match '/search', to:'users#search'
  match '/t', to: 'users#tro'
  match 'microposts/search', to:'microposts#search'
  match '/postindex', to: 'microposts#index'
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete


 
end
