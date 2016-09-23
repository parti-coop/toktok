module Admin
  class MatchesController < BaseController
    load_and_authorize_resource

    def create
      @match.save
    end

    private

    def match_params
      params.require(:match).permit(:committee_id, :project_id)
    end
  end
end
