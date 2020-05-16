Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  
  # Dashboard is a singular resource because each user
  # will only have one dashboard.
  resource :dashboard, only: [:show] do
    member do
      get "listings"
      get "orders"
      get "purchases"
    end
  end

  resources :listings do
    resources :orders
  end
end
