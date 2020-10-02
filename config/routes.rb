Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  
  resources :users, only: [:show, :edit, :update] do
    resources :credit_cards, only: [:new, :create], as: :cards
    resources :destinations, only: [:new, :create, :edit, :update]
    resources :profiles, only: [:edit, :update]
    collection do
      get 'destination'
      get 'card'
      get 'logout'
    end
  end

end
