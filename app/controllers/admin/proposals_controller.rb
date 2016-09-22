module Admin
  class ProposalsController < BaseController
    load_and_authorize_resource
    def index
      @proposals = Proposal.all
    end
  end
end
