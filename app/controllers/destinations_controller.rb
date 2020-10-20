class DestinationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_destination, only: [:show, :destroy]

  def index
    @destinations = current_user.destinations.includes(:user)
  end

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.new
  end
  
  def show
  end

  def update
  end

  def destroy
  end

  private

  def set_destination
    @destination = Destination.find_by(user_id: params[:user_id])
  end

  def destination_params
    params.require(:destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone)
  end

end
