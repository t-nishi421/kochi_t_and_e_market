class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find(params[:id])
  end
  
  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to edit_profile_path(@profile), notice: "本人情報を変更しました"
    else
      redirect_to edit_profile_path(@profile), alert: "本人情報を変更できませんでした"
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :birthday)
  end
  
end
