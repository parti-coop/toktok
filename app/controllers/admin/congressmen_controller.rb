module Admin
  class CongressmenController < BaseController
    load_and_authorize_resource

    def create
      @congressman = Congressman.new(congressman_params)
      errors_to_flash(@congressman) unless @congressman.save
      redirect_to :back
    end

    def update
      if @congressman.update(congressman_params)
        redirect_to admin_committee_path(@congressman.committee_id)
      else
        errors_to_flash(@congressman)
        render 'edit'
      end
    end

    def destroy
      @congressman = Congressman.find(params[:id])
      @congressman.destroy
      redirect_to :back
    end

    private

    def congressman_params
      params.require(:congressman).permit(:name, :committee_id, :description, :party, :image, :image_cache, :facebook_url, :twitter_url)
    end
  end
end
