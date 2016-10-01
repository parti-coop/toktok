class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:me, :kill_me]
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

  def kill_me
    current_user.update_attributes(uid: SecureRandom.hex(10))
    sign_out current_user
    redirect_to root_path
  end
end
