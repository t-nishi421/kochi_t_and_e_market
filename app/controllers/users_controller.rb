class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @introduction = Introduction.find_by(user_id: params[:id])
    @introduction = Introduction.new if @introduction.nil?
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
