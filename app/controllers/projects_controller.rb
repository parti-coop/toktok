class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :reset_meta_tags, only: :show

  def index
    @projects = Project.all.page(params[:page])
  end

  def new
    @project = Project.new
  end

  def create
    @project.user = current_user
    if @project.save
      redirect_to [:thanks, @project]
    else
      errors_to_flash(@project)
      render 'new'
    end
  end

  def search
    @projects = Project.search_for(params[:keyword]).page(params[:page])

    case params[:sort]
    when 'hottest'
      @projects = @projects.hottest.page(params[:page])
    when 'matching'
      @projects = @projects.matching.page(params[:page])
    else
      @projects = @projects.recent.page(params[:page])
    end
  end

  def reset_meta_tags
    prepare_meta_tags({title: @project.title, description: @project.summary.html_safe, image: @project.image.url, url: request.original_url})
  end

  private

  def project_params
    params.require(:project).permit(:title, :body, :proposal_id, :participations_goal_count, :image, :image_cache, :summary, :proposer, :proposer_email, :proposer_phone, :proposer_description, :matching_staff_message, :on_running, :running_platform_url, committee_ids: [], attachments_attributes: [ :id, :source, :source_cache, :_destroy ])
  end
end
