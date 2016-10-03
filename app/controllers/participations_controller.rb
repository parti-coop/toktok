class ParticipationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project, shallow: true

  def index
    @participations = @project.participations.recent
  end

  def create
    if params[:participation_at_home] == 'true'
      @participation.user = current_user
      @participation.save
      redirect_back_with_anchor anchor: "anchor-participation-home-#{@participation.project.id}", fallback_location: root_path
    else
      @participation.user = current_user
      @participation.save
      redirect_back_with_anchor anchor: 'anchor-participation', fallback_location: @participation.project
    end
  end

  def cancel
    if params[:participation_at_home] == 'true'
      @participation = Participation.find_by user: current_user, project: @project
      @participation.try(:destroy)
      redirect_back_with_anchor anchor: "anchor-participation-home-#{@project.id}", fallback_location: root_path
    else
      @participation = Participation.find_by user: current_user, project: @project
      @participation.try(:destroy)
      redirect_back_with_anchor anchor: 'anchor-participation', fallback_location: @project
    end
  end
end
