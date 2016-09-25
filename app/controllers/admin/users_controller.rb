module Admin
  class UsersController < BaseController
    def role
      user = User.find_by nickname: params[:user_nickname]
      if user.present?
        user.update_attributes(role: params[:role])
      else
        flash[:info] = t('message.not_found')
      end

      redirect_back fallback_location: admin_staffs_path
    end
  end
end
