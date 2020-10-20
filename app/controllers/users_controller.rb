class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.profile
  end

  def on_sale
    @items = current_user.items.includes(:user).references(:user).where(trading_status_id: 2)
  end

  def logout
  end
end
