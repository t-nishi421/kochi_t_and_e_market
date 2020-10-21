class SignupsController < ApplicationController
  def step1
    @user = User.new
  end

  def step1_validates
    @user = User.new(user_params)
    if @user.valid?
      session["regist_data"] = {user: @user.attributes}
      session["regist_data"][:user]["password"] = params[:user][:password]
      redirect_to action: :step2
    else
      render "step1"
    end
  end

  def step2
    @profile = Profile.new
  end

  def step2_validates
    @profile = Profile.new(profile_params)
    if @profile.valid?
      session["regist_data"][:profile] = @profile
      redirect_to action: :step3
    else
      render "step2"
    end
  end

  def step3
    @destination = Destination.new
  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.valid?
      @user = User.create(session["regist_data"]["user"])
      @profile = Profile.new(session["regist_data"]["profile"].merge(user_id: @user.id))
      @profile.save
      @destination = Destination.create(destination_params.merge(user_id: @user.id, use: true))
      session["regist_data"].clear
      sign_in(:user, @user)
      redirect_to root_path
    else
      render "step3"
    end
  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:profile).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :birthday)
  end

  def destination_params
    params.require(:destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone)
  end

end
