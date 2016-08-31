class PagesController < ApplicationController
  def home
    @proposals = Proposal.all
  end
end
