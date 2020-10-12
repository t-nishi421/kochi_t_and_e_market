class ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new()
    @item.item_images.new
    #データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    binding.pry
    if @item.valid? && @item.save
      redirect_to root_path
    else
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
    # 未実装 → :category_idを追加予定
    # 未実装 → :brand_idを追加予定
    params.require(:item).permit(:name, :price, :introduction, :condition_id,
                                 :shipping_cost_id, :preparation_day_id, :prefecture_id,
                                 item_images_attributes: [:src, :_destroy, :id])
  end
end
