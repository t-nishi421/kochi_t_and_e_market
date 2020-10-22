class IntroductionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @intro = Introduction.find_by(user_id: params[:user_id])
    @items = Item.where(user_id: params[:user_id])
    @favorite = FavoriteItem.where(item_id: @items.ids)
  end

  def create
    @intro = Introduction.new(intro_params)
    if @intro.save
      redirect_to user_path(current_user), notice: "自己紹介を作成しました"
    else
      redirect_to user_path(current_user), alert: "自己紹介を作成できませんでした"
    end
  end
  
  def update
    @intro = Introduction.find(params[:id])
    if @intro.update(intro_params)
      redirect_to user_path(current_user), notice: "自己紹介を更新しました"
    else
      redirect_to user_path(current_user), alert: "自己紹介を更新できませんでした"
    end
  end

  private

  def intro_params
    params.require(:introduction).permit(:content).merge(user_id: current_user.id)
  end

end
