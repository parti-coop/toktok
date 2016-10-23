module Admin
  class TimelinesController < BaseController
  	load_and_authorize_resource :project
  	load_and_authorize_resource through: :project, shallow: true

  	def create
  		if @timeline.save
  			redirect_back fallback_location: [:admin, @project]
  		else
  			errors_to_flash(@project)
  			render 'new'
  		end
  	end

    def update
      if @timeline.update_attributes(update_params)
        redirect_to [:admin, @timeline.project, :timelines]
      else
        errors_to_flash(@project)
        render 'new'
      end
    end

  	private

  	def create_params
      params.require(:timeline).permit(:actor, :image, :image_cache, :body, :project_id, :congressman_id, :timeline_date)
    end

    def update_params
      params.require(:timeline).permit(:actor, :image, :image_cache, :body, :project_id, :congressman_id, :timeline_date)
    end
  end
end