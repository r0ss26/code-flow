Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  get "seller", to: "listings#seller"
  get "buyer", to: "listings#buyer"
  
  resources :listings do
    resources :orders
  end
end
