class SignupsController < ApplicationController
  def sms_confirmation_send
   @profile=Profile.new
     render layout: 'application-off-header-footer.haml'
  end

  def sms_confirmation_certify
   current_user.profile.update(profile_params)
     render layout: 'application-off-header-footer.haml'
  end

  def address
   @profile=current_user.profile
     render layout: 'application-off-header-footer.haml'
  end

    def address_create
   current_user.profile.update(profile_params)
   redirect_to controller: 'cards', action: 'new'
  end
  def index
     render layout: 'application-off-header-footer.haml'
  end

  def new
     render layout: 'application-off-header-footer.haml'
  end

  def show
     render layout: 'application-off-header-footer.haml'
  end

  private

  def profile_params
    params.require(:profile).permit(:phone_number)
  end



end
