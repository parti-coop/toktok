class PagesController < ApplicationController
  def home
    @proposals = Proposal.all
    @questions = Question.all
    @projects = Project.hottest
  end
end
