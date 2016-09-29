class ParticipationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project, shallow: true

  def index
    @participations = @project.participations.recent
  end

  def create
    @participation.user = current_user
    @participation.save

    respond_to do |format|
      format.js
      format.any { redirect_to root_path }
    end

  end

  def cancel
    @participation = Participation.find_by user: current_user, project: @project
    @participation.try(:destroy)

    respond_to do |format|
      format.js
      format.any { redirect_to root_path }
    end
  end
end
