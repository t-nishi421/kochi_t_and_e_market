class PurchaseHistoriesController < ApplicationController

  def index
    @items = Item.includes(:item_images, :purchase_histories).where(purchase_histories: {user_id: current_user.id}).order(updated_at: 'DESC')
  end

end
