class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:me, :kill_me, :edit_current_password, :update_current_password]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def me
    @user = current_user
    render 'show'
  end

  def update_current_password
    if current_user.update_with_password params.require(:user).permit(:password, :password_confirmation, :current_password)
      bypass_sign_in(current_user)
      redirect_to :current_user
    else
      render 'edit_current_password'
    end
  end

  def kill_me
    current_user.update_attributes(uid: SecureRandom.hex(10))
    sign_out current_user
    redirect_to root_path
  end
end
