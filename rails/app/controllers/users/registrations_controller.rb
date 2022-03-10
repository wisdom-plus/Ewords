# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout 'users'
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up

  # POST /resource

  # GET /resource/edit

  # PUT /resource

  # DELETE /resource

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.

  protected

  # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    end

  # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    end

  # The path used after sign up.

  # The path used after sign up for inactive accounts.

  private

    def respond_to_destroy
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name), status: :see_other }
    end
end
