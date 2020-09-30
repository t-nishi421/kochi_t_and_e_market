class SignupsController < ApplicationController
  def step1
    @user = User.new
  end

  def step1_validates
    @user = User.new(user_params)
    if @user.valid?
      session[:user] = @user
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
      session[:profile] = @profile
      redirect_to action: :step3
    else
      # 各種バリデーション,メッセージ未実装
      render "step2"
    end
  end

  def step3
    @destination = Destination.new
  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.valid?
      # 各データ保存処理
    else
      # 各種バリデーション,メッセージ未実装
      render "step3"
    end
  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :email, :password)
  end

  def profile_params
    params.require(:profile).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :birthday)
  end

  def destination_params
    params.require(:destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :prefecture, :city, :house_number, :building_name, :telephone)
  end

end
