class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, :only => :create

  # Overwrite update_resource to let users to update their user without giving their password
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def sign_up_params
    params.require(:user).permit(:remember_me, :nickname, :image, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:remember_me, :nickname, :image, :email)
  end

  def after_inactive_sign_up_path_for(resource)
    root_path
  end
end
