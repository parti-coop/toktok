module Admin
  class MatchesController < BaseController
    load_and_authorize_resource :project
    load_and_authorize_resource through: :project, shallow: true

    def create
      if @match.save
        redirect_back fallback_location: [:admin, @project]
      else
        errors_to_flash(@project)
        render 'new'
      end
    end

    def destroy
      errors_to_flash(@project) unless @match.destroy
      redirect_back fallback_location: [:admin, @project]
    end

    def update
      if @match.update_attributes(update_params)
        redirect_to [:admin, @match.project, :matches]
      else
        errors_to_flash(@project)
        render 'new'
      end
    end

    private

    def create_params
      params.require(:match).permit(:congressman_id, status: :calling)
    end

    def update_params
      params.require(:match).permit(:status)
    end
  end
end
