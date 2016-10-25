module Admin
  class BaseController < ApplicationController
    before_action :verify_staff

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def download_emails
      @emails = User.all.select { |u| u.email.present? }.map { |u| {email: u.email, name: u.nickname, provider: u.provider} }.uniq { |u| u[:email] }
      respond_to do |format|
        format.xlsx
      end
    end

    private

    def verify_staff
      redirect_to root_url unless current_user.try(:role).try(:staff?)
    end
  end 
end
