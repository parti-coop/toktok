module Admin
  class CommitteesController < BaseController
    load_and_authorize_resource

    def index
      @committees = Committee.all
      @committee = Committee.new

    end
    def show
      @congressman = Congressman.new
    end

    def create
      if @committee.save
        redirect_to [:admin, @committee]
      else
        errors_to_flash(@committee)
        redirect_to admin_committees_url
      end
    end

    def update
      if @committee.update(committee_params)
        redirect_to [:admin, @committee]
      else
        errors_to_flash(@committee)
        render 'edit'
      end
    end

    def destroy
      errors_to_flash(@committee) unless @committee.destroy
      redirect_to admin_committees_url
    end

    private

    def committee_params
      params.require(:committee).permit(:name, :description)
    end
  end
end
