module Admin
  class BaseController < ApplicationController
    before_action :verify_staff

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def download_emails
      if params[:project_id].present?
        project = Project.find(params[:project_id])
        @emails = project.participations.select { |p| p.user.email.present? }.map { |p| {project: p.project.title, email: p.user.email, name: p.user.nickname, provider: p.user.provider} }.uniq { |p| p[:email]}
      else
        @emails = User.all.select { |u| u.email.present? }.map { |u| {email: u.email, name: u.nickname, provider: u.provider} }.uniq { |u| u[:email] }
      end
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
