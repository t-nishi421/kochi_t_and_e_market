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
  resources :items, only: [:index, :new, :edit, :destroy] do
    collection do
      post 'new', to: 'items#create'
      get 'bookmark', defaults: { fomat: 'json'}
      get 'delete_bookmark', defaults: { fomat: 'json'}
    end
    member do
      patch 'edit', to: 'items#update'
      post 'comment', to:'items#comment'
    end
  end
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
  resources :profiles, only: [:edit, :update] # 本人情報
  resources :destinations, only: [:new, :create, :show, :update, :destroy] # お届け先住所

  # マイページのルーティング
  resources :users, only: [:show, :edit, :update] do
    resources :destinations, only: [:index] do # お届け先住所
      collection do
        post 'change'
      end
    end
    resources :credit_cards, only: [:index, :update, :destroy] #  クレジットカード
      resources :purchase_histories, only: [:index] # 購入履歴
      member do
      get 'on_sale' # 出品中の商品リスト
      get 'logout' # マイページのログアウト画面
      get 'bookmark' # お気に入り登録リスト
    end
  end

end
