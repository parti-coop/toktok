module Admin
  class BaseController < ApplicationController
    layout 'admin'

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    before_action :verify_staff

    private

    def verify_staff
      redirect_to root_url unless current_user.try(:role).try(:staff?)
    end
  end
end
