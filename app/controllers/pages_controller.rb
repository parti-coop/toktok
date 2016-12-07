class PagesController < ApplicationController
  def home
    @proposals = Proposal.all
    @questions = Question.all
    @projects = Project.recent.page(params[:page])
    @mainslides = Mainslide.all.priority.sequential
  end
end
