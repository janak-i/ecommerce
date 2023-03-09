Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/signup", to: "sessions#signup"
  post "/login",  to: "sessions#login"

  post "/change_password", to: "sessions#change_password"
  post "/add_item",  to: "carts#add_item"

  get 'carts/:id' => 'carts#show'
  delete 'carts/:id' => 'carts#destroy'

  post 'cart_products/:id/add' => 'cart_products#add_quantity'
  post 'cart_products/:id/reduce' => 'cart_products#reduce_quantity'
  post 'cart_products' => 'cart_products#create'
  get 'cart_products/:id' => 'cart_products#show'
  delete 'cart_products/:id' => 'cart_products#destroy'

  resources :orders
  resources :products

  resources :orders
  devise_for :users
  get '/', to: 'orders#index'
  post '/orders/submit', to: 'orders#submit'
end
