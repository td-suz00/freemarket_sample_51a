class SignupsController < ApplicationController
  layout 'application-off-header-footer.haml'
  def sms_confirmation_send
    @profile=Profile.new
  end

  def sms_confirmation_certify
    if  profile_params[:phone_number].present?
      current_user.profile.update(profile_params)
    else
      @profile=Profile.new
      @errors='未記入箇所があります'
      render 'sms_confirmation_send'
    end
  end

  def address
    @profile=current_user.profile
  end

  def address_create
    if profile_params[:postalcode].present?\
       &&profile_params[:address_prefecture].present?\
       &&profile_params[:address_city].present?\
       &&profile_params[:address_street_number].present?
      current_user.profile.update(profile_params)
      redirect_to new_user_card_path(1)
    else
      @profile=current_user.profile
      @errors='未記入箇所があります'
      render 'address'
    end
  end

  def index
  end

  def new
  end

  def show
  end
def succesful 
end
  private

  def profile_params
    params.require(:profile).permit(:phone_number,:family_name, :last_name, :kana_family_name, :kana_last_name, :postalcode, :address_prefecture, :address_city, :address_street_number,:address_building_name)
  end

end
