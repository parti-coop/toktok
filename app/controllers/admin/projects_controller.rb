module Admin
  class ProjectsController < BaseController
    load_and_authorize_resource
    before_action :should_exists_committees, only: [:new, :edit]

    def index
      @projects = Project.all
    end

    def create
      @project = Project.new(project_params)
      @project.user = current_user
      if @project.save
        redirect_to [:admin, @project]
      else
        errors_to_flash(@project)
        render 'new'
      end
    end

    def new
      @proposal = Proposal.find_by id: params[:proposal_id]
      @project = Project.new(proposal: @proposal)
    end

    def update
      if @project.update(project_params)
        redirect_to [:admin, @project]
      else
        errors_to_flash(@project)
        render 'edit'
      end
    end

    def destroy
      errors_to_flash(@project) unless @project.destroy
      redirect_to admin_projects_path
    end

    private

    def project_params
      params.require(:project).permit(:title, :body, :proposal_id, :participations_goal_count, :image, :image_cache, :summary, :proposer, :proposer_description, :matching_staff_message, :on_running, :running_platform_url, committee_ids: [], attachments_attributes: [ :id, :source, :source_cache, :_destroy ])
    end

    def should_exists_committees
      unless Committee.exists?
        flash[:info] = t('messages.empty_committees')
        redirect_back fallback_location: admin_projects_path
      end
    end
  end
end
