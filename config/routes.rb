Rails.application.routes.draw do
  root to: "listings#index"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "seller", to: "listings#seller"
  get "buyer", to: "listings#buyer"
  resources :listings do
    resources :orders
  end
end
