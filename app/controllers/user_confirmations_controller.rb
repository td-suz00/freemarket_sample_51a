class UserConfirmationsController < ApplicationController

  def create
  end

  def edit
    @user = User.find(params[:user_id]).profile
  end

  def update
    @user = User.find(params[:user_id]).profile
    @user.update(profile_params)
    redirect_back(fallback_location: root_path)
  end

  private
  def profile_params
    params.require(:profile).permit(:postalcode, :address_prefecture, :address_city, :address_street_number, :address_building_name)
  end

end
