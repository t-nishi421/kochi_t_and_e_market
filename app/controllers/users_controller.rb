class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def on_sale
    @items = Item.includes(:item_images).where(user_id: params[:id], trading_status_id: 2)
  end

  def logout
  end

  def bookmark
    @items = Item.includes(:item_images, :favorite_items).where(favorite_items: {user_id: current_user.id})
  end
end
