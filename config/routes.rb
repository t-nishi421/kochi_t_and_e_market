Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  
  resources :users, only: [:show] do
    resources :credit_cards, only: [:new, :create, :edit, :update], as: :cards
    resources :destinations, only: [:new, :create, :edit, :update]
    collection do
      get 'logout'
      get 'destination'
      get 'card'
    end
  end

end
