class ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new();
  end

  def create
    @item = Item.new(item_params);
  end

  def show
  end

  private

  def item_params
    # 未実装 → category_idを追加予定
    params.require(:item).permit(:name, :price, :introduction, :brand_id, :condition_id, :shipping_cost_id, :preparation_day_id, :prefecture_id)
  end
end