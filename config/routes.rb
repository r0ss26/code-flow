Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :users do
    resource :profile do
      resources :reviews
    end
  end
  
  # Dashboard is a singular resource because each user
  # will only have one dashboard.
  resource :dashboard, only: [:show] do
    member do
      get "listings"
      get "sales"
      get "purchases"
      get "reviews"
    end
  end

  resources :listings do
    resources :orders
  end

  resources :conversations do
    resources :messages
  end

end
