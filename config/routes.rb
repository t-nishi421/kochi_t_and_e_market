Rails.application.routes.draw do
  devise_for :users, :controllers => { # deviseのルーティング
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'  
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  resources :signups, only: [:index] do # 新規登録のルーティング
    collection do
      get 'step1'   # deviseの情報
      post 'step1', to: 'signups#step1_validates'  # step1のバリデーションチェック
      get 'step2'  # 本人情報
      post 'step2', to: 'signups#step2_validates' # step2のバリデーションチェック
      get 'step3'  # 送付先情報
      post 'step3', to: 'signups#create' # 入力した情報すべてを保存 こっちもrenderするなら揃える
    end
  end

  resources :items, only: [:index, :show, :new] do
    member do
      get 'purchase'
    end
    #子、孫カテゴリーのJSON用ルーティング設定
    collection do
      get 'get_category_children', defaults: { fomat: 'json'}
      get 'get_category_grandchildren', defaults: { fomat: 'json'}
      get 'search'
    end
  end

  root 'items#index'
  #resources :items, only: [:show] do
    #member do
      #get 'purchase'
    #end
  #end

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
