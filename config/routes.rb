Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :users do
    resource :profile 
  end
    resources :reviews
  end
  
  # Dashboard is a singular resource because each user
  # will only have one dashboard.
  resource :dashboard do
    member do
      get "listings"
      get "sales"
      get "purchases"
      get "reviews"
      get "favorites"
    end
  end

  resources :listings do
    put "favorite"
    patch "favorite"
    resources :orders
  end

  resources :conversations do
    resources :messages
  end

end
