class PurchaseHistoriesController < ApplicationController

  def index
    @history = current_user.purchase_histories.includes(:user)
  end

end
