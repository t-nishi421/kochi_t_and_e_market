class SignupsController < ApplicationController
  def step1
    @user = User.new
  end

  def step1_validates
    @user = User.new(user_params)
    if User.check_params(@user)
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
    render "step2"
  end

  def step3

  end

  def create

  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :email, :password)
  end

  def profile_params
    params.require(:profile).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :birthday)
  end
end
