module Admin
  class BaseController < ApplicationController
    layout 'admin'

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    before_filter :verify_admin

    private

    def verify_admin
      redirect_to root_url unless current_user.try(:admin?)
    end
  end
end
