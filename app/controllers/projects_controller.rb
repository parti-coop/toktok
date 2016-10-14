class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :reset_meta_tags, only: :show

  def index
    @projects = Project.all
  end

  def reset_meta_tags
    prepare_meta_tags({title: @project.title, description: @project.summary.html_safe, image: @project.image.url, url: request.original_url})
  end
end
