class ProposalsController < ApplicationController
  load_and_authorize_resource

  def index
    @proposals = Proposal.all
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal.user = current_user
    if @proposal.save
      redirect_to [:thanks, @proposal]
    else
      errors_to_flash(@proposal)
      render 'new'
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to @proposal
    else
      render 'edit'
    end
  end

  def destroy
    @proposal.destroy
    redirect_to root_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:title, :proposer_name, :proposer_email, :proposer_phone, :body, attachments_attributes: [ :id, :source, :source_cache, :_destroy ])
  end
end
