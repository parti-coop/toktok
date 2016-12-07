class PagesController < ApplicationController
  def home
    @proposals = Proposal.all
    @questions = Question.all
    @projects = Project.recent.page(params[:page])
  end
end
