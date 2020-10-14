class ItemsController < ApplicationController
  def index
     @items = Item.includes(:item_images).order('created_at DESC').limit(5)
  end
  
  def new
    if user_signed_in?
      @item = Item.new()
      @item.item_images.new
      #データベースから、親カテゴリーのみ抽出し、配列化
      @category_parent_array = Category.where(ancestry: nil)
    else
      redirect_to root_path
    end
  end

  def create
    Brand.saveIfNotPresent(brand_params)
    @item = Item.new(item_params)
    if @item.valid? && @item.save
      redirect_to root_path
    else
      @category_parent_array = Category.where(ancestry: nil)
      render "new"
    end
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

  private

  def item_params
    if brand_params != ""
      brand_id = Brand.find_by(name: brand_params).id
    else
      brand_id = nil
    end
    params.require(:item).permit(:name, :price, :introduction, :condition_id,
                                 :shipping_cost_id, :preparation_day_id, :prefecture_id,
                                 item_images_attributes: [:src, :_destroy, :id]).merge(trading_status: '出品中', category_id: category_params, brand_id: brand_id, user_id: current_user.id)
  end

  def brand_params
    params[:item][:brand]
  end

  def category_params
    params[:item][:category_id]
  end
end
