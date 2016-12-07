class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :reset_meta_tags, only: :show

  def index
    @projects = Project.all.page(params[:page])
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
end
