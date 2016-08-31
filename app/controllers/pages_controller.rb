class PagesController < ApplicationController
  def home
    @proposals = Proposal.all
    @questions = Question.all
  end
end
