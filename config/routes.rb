Rails.application.routes.draw do
  resources :orders
  devise_for :users
  get 'user_index', to: 'users#index'
  resources :products
  root 'products#index'
  get 'create_payment', to: 'payments#create_payment'
  get 'order_place', to: 'payments#order_place'
  get 'payment_failed', to: 'payments#payment_failed'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
