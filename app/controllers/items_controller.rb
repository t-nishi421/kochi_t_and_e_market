class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :purchase_confirmation, :purchase, :purchase_completed, :edit, :update, :destroy]
  before_action :owner, only: [:purchase_confirmation, :purchase, :purchase_completed]
  before_action :other_owner, only: [:update, :destroy]
  before_action :on_sale_only, only: [:purchase_confirmation, :purchase]

  def index
     @items = Item.includes(:item_images).order('created_at DESC').limit(5)
  end
  
  def new
      @item = Item.new()
      @item.item_images.new
      #データベースから、親カテゴリーのみ抽出し、配列化
      @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    save_unregistered_brands()
    @item = Item.new(item_params)
    if @item.valid? && @item.save
      redirect_to item_path(@item.id), notice: "商品を出品しました"
    else
      if @item.item_images.blank?
        @item.item_images.new
      end
      get_categories_to_item
      @category_parent_array = Category.where(ancestry: nil)
      render "new"
    end
  end

  def show
    @comments = Comment.includes(:user).where(item_id: @item.id)
    @comment = Comment.new
    get_categories_to_item
    @whetherBookmarked = FavoriteItem.whetherBookmarked(current_user.id, @item.id)
  end

  def comment
    @comment = Comment.new(comment_params)
    if @comment.valid? && @comment.save
      redirect_to item_path(params[:id]), notice: "コメントを投稿しました"
    else
      redirect_to item_path(params[:id]), alert: "コメントの投稿に失敗しました"
    end
  end
  
  def bookmark
    if FavoriteItem.where(user_id: current_user.id, item_id: params[:item_id].to_i) == []
      FavoriteItem.create(user_id: current_user.id, item_id: params[:item_id].to_i)
    end
  end

  def delete_bookmark
    FavoriteItem.where(user_id: current_user.id, item_id: params[:item_id].to_i).delete_all
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
    @destination = Destination.find_by(user_id: current_user)
    @prefecture = Prefecture.find_by(id: @destination.prefecture_id)
    @image = @item.item_images.first
    @card = CreditCard.get_card(current_user.credit_card.customer_token) if current_user.credit_card
  end
  
  def purchase # 購入アクション
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    if Payjp::Charge.create(
       amount: @item.price, # 商品の値段
       customer: current_user.credit_card.customer_token, # 顧客のトークン
       currency: 'jpy'  # 通貨の種類
     )
       @item.update(trading_status_id: 4)
       redirect_to purchase_completed_item_path(@item), notice: "お買い上げありがとうございます！"
    else
      redirect_to purchase_confirmation_item_path(@item), alert: "商品を購入できませんでした" 
    end
  end
  
  def purchase_completed # 購入完了画面
    @destination = Destination.find_by(user_id: current_user)
    @prefecture = Prefecture.find_by(id: @destination.prefecture_id)
    @image = @item.item_images.first
    @card = CreditCard.get_card(current_user.credit_card.customer_token)
  end

  
  def edit
    get_categories_to_item
    get_categories_array
  end
  
  def update
    save_unregistered_brands()
    if @item.valid? && @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      get_categories_to_item
      get_categories_array
      render "edit"
    end
  end
  
  def destroy
    if @item.destroy
      redirect_to user_path(current_user), notice: "商品を削除しました"
    else
      render "show"
    end
  end

  private

  def item_params
    if brand_params == nil || ""
      brand_id = nil
    else
      brand_id = Brand.find_by(name: brand_params).id
    end
    params.require(:item).permit(:name, :price, :introduction, :condition_id,
                                 :shipping_cost_id, :preparation_day_id, :prefecture_id,
                                 item_images_attributes: [:src, :_destroy, :id]).merge(trading_status_id: 2, category_id: category_params, brand_id: brand_id, user_id: current_user.id)
  end

  def brand_params
    params[:item][:brand]
  end

  def category_params
    params[:item][:category_id]
  end

  def comment_params
    params.require(:comment).permit(:comment).merge(item_id: params[:id], user_id: current_user.id)
  end

  def get_categories_to_item
    @category_id = @item.category_id
    unless @category_id == 0 || @category_id == nil
      @category_parent = Category.find(@category_id).parent.parent
      @category_child = Category.find(@category_id).parent
      @category_grandchild = Category.find(@category_id)
    end
  end

  def get_categories_array
    @category_parent_array = Category.where(ancestry: nil)
    unless @category_parent == nil
      @category_child_array = Category.find(@category_parent.id).children
      @category_grandchildren_array = Category.find(@category_child.id).children
    end
  end

  def save_unregistered_brands
    Brand.saveIfNotPresent(brand_params)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def owner # 出品者本人なら商品購入できない
    if @item.user_id == current_user.id
      redirect_to item_path(@item), alert: "ご自身の商品は購入できません"
    end
  end

  def other_owner # 出品者本人でないなら更新・削除できない
    unless @item.user_id == current_user.id
      redirect_to item_path(@item), alert: "権限がありません"
    end
  end

  def on_sale_only # 出品中でないなら購入できない
    unless @item.trading_status_id == 2
      redirect_to item_path(@item), alert: "この商品は購入できません"
    end
  end

end
