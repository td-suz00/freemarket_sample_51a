class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?
  before_action :check_address_nil,if: :use_check_address_nil?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,profile_attributes: [:family_name,:last_name,:kana_family_name,:kana_last_name,:birth_ymd,:user_id]])
  end

  private

  def production?
    Rails.env.production?
  end
  
  def check_address_nil
    if current_user && current_user.profile.postalcode.nil?
    redirect_to sign_out_path 
    current_user.destroy
    end
  end
  
  def use_check_address_nil?
    true
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.production[:basic_auth_user] && password == Rails.application.credentials.production[:basic_auth_password]
    end
  end
end
