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

    if params[:participation_at_home]
      redirect_to @project, participation_at_home: params[:participation_at_home]
    else
      redirect_back fallback_location: @participation.project
    end
  end

  def cancel
    @participation = Participation.find_by user: current_user, project: @project
    @participation.try(:destroy)

    redirect_back fallback_location: @project
  end

end
