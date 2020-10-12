class ItemsController < ApplicationController
  def index
  end
  
  def new
    #データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
  end

  def show
    @item = Item.find(params[:id])
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  def purchase_confirmation # 購入内容確認画面
    @item = Item.find(params[:id])
    @card = CreditCard.get_card(current_user.credit_card.customer_token) if current_user.credit_card
  end
  
  def purchase # 購入アクション
    @item = Item.find(params[:id])
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer_token = current_user.credit_card.customer_token
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      customer: customer_token, # 顧客のトークン
      currency: 'jpy'  # 通貨の種類
    )
    redirect_to purchase_completed_item_path(@item), notice: "お買い上げありがとうございます！"
  end
  
  def purchase_completed # 購入完了画面
    @item = Item.find(params[:id])
    @card = CreditCard.get_card(current_user.credit_card.customer_token) if current_user.credit_card
  end
end