module Admin
  class ProposalsController < BaseController
    load_and_authorize_resource
    def index
      @proposals = Proposal.all
    end

    def destroy
      errors_to_flash(@proposal) unless @proposal.destroy
      redirect_to admin_proposals_path
    end
  end
end
