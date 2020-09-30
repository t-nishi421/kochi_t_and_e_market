class SignupsController < ApplicationController
  def step1
    @user = User.new
  end

  def step1_validates
    @user = User.new(user_params)
    if @user.save
      redirect_to action: :step2
    else
      render "step1"
    end
  end

  def step2

  end

  def step2_validates

  end

  def step3

  end

  def create

  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :email, :password)
  end
end
