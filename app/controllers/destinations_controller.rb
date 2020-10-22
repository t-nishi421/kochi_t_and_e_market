class DestinationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_destination, only: [:update, :show, :destroy]

  def index
    @destinations = current_user.destinations.includes(:user)
  end

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      redirect_to user_destinations_path(current_user), notice: "新しいお届け先を登録しました"
    else
      flash.now[:alert] = "お届け先を登録できませんでした"
      render :new
    end
  end
  
  def show
  end

  def update
    if @destination.update(destination_params)
      redirect_to user_destinations_path(@destination), notice: "お届け先の情報を変更しました"
    else
      flash.now[:alert] = "お届け先の情報を変更できませんでした"
      render :show
    end
  end

  def destroy
    @destinations = current_user.destinations.includes(:user).references(:user).where.not(id: @destination.id)
    if @destinations.blank?
      redirect_to user_destinations_path(current_user), alert: "お届け先の情報は１つ以上必要です"
    else
      if @destination.destroy
        if @destination.use == true
          @destinations.first.update(use: true)
          redirect_to user_destinations_path(current_user), notice: "お届け先の情報を削除しました"
        else
          redirect_to user_destinations_path(current_user), notice: "お届け先の情報を削除しました"
        end
      else
        render :index
        flash.now[:alert] = "お届け先の情報を削除できませんでした"
      end
    end
  end

  def change
    @destination = Destination.find(params[:destination])
    @destinations = current_user.destinations.includes(:user).references(:user).where.not(id: params[:destination])
    if @destinations.update_all(use: false) && @destination.update(use: true)
      redirect_to user_destinations_path(current_user), notice: "お届け先を変更しました"
    else
      render :show
      flash.now[:alert] = "お届けを変更できませんでした"
    end
  end

  private

  def set_destination
    @destination = Destination.find(params[:id])
  end

  def destination_params
    params.require(:destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone).merge(user_id: current_user.id)
  end

end
