class ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new()
    @item.item_images.new
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
