class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @profile = Profile.find_by(user_id: params[:id])
  end
  
  def update
    @profile = Profile.find_by(id: params[:id])
    if @profile.valid? && @profile.update(profile_params)
      redirect_to edit_profile_path(@profile.user_id), notice: "本人情報を変更しました"
    else
      redirect_to edit_profile_path(@profile.user_id), alert: "本人情報を変更できませんでした"
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :birthday).merge(user_id: current_user.id)
  end
  
end
