Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :users do
    resource :profile do
      member do
        get "education"
        get "employment"
        get "listings"
        get "reviews"
      end
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
    resources :orders
  end

  resources :conversations do
    resources :messages
  end

end
