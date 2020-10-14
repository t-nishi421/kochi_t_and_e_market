Rails.application.routes.draw do
  root 'items#index'

  # deviseのルーティング
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'  
  } 
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  # 新規登録のルーティング
  resources :signups, only: [:index] do
    collection do
      get 'step1'   # deviseの情報
      post 'step1', to: 'signups#step1_validates'  # step1のバリデーションチェック
      get 'step2'  # 本人情報
      post 'step2', to: 'signups#step2_validates' # step2のバリデーションチェック
      get 'step3'  # 送付先情報
      post 'step3', to: 'signups#create' # 入力した情報すべてを保存 こっちもrenderするなら揃える
    end
  end


  # 商品関係のルーティング
  resources :items, only: [:index, :new, :create, :destroy]
  resources :items, only: [:show] do
    member do
      get 'purchase_confirmation'
      post 'purchase'
      get 'purchase_completed'
    end
    #子、孫カテゴリーのJSON用ルーティング設定
    collection do
      get 'get_category_children', defaults: { fomat: 'json'}
      get 'get_category_grandchildren', defaults: { fomat: 'json'}
    end
  end

  resources :credit_cards, only: [:new, :create] #  クレジットカード

  # マイページのルーティング
  resources :users, only: [:show, :edit, :update] do
      resources :credit_cards, only: [:index, :update, :destroy] #  クレジットカード
      resources :destinations, only: [:new, :create, :edit, :update] # お届け先住所
      resources :profiles, only: [:edit, :update] # 本人情報
      member do
      get 'on_sale' # 出品中の商品リスト
      get 'destination' # マイページのお届け先住所遷移画面
      get 'logout' # マイページのログアウト画面
    end
  end

end
