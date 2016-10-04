class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :reset_meta_tags, if: "request.get?"

  def index
    @projects = Project.all
  end

  def reset_meta_tags
    prepare_meta_tags({title: @project.title, description: @project.summary, image: @project.image.url, url: request.original_url})
  end
end
