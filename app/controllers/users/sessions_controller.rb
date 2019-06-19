# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'application-off-header-footer'
  prepend_before_action :confirm_recaptcha, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end
  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def confirm_recaptcha
    unless verify_recaptcha(model: resource)
      self.resource = User.new
        render 'new' and return
      end
  end
end