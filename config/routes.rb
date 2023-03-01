Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/signup", to: "sessions#signup"
  post "/login",  to: "sessions#login"
  post "/add_item",  to: "carts#add_item"

  resources :orders
  resources :products
  resources :line_items
  resources :carts

end
