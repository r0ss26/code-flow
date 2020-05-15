Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  get "seller/listings", to: "listings#seller_listings"
  get "seller/orders", to: "orders#seller_orders"
  get "buyer", to: "listings#buyer"
  
  resources :listings do
    resources :orders
  end
end
