class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def on_sale
    @items = current_user.items.includes(:user).references(:user).where(trading_status_id: 2)
  end

  def logout
  end

  def bookmark
    @items = FavoriteItem.includes(:item).where(user_id: current_user.id)
  end
end
