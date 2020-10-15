class UsersController < ApplicationController

  def show
  end

  def on_sale
    @items = current_user.items.includes(:user).references(:user).where(trading_status: "出品中")
  end

  def destination
  end

  def logout
  end
end
