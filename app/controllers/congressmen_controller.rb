class CongressmenController < ApplicationController
  def create
    @congressman = Congressman.new(congressman_params)
    errors_to_flash(@congressman) unless @congressman.save
    redirect_to :back

  end

  def destroy
    @congressman = Congressman.find(params[:id])
    @congressman.destroy
    redirect_to :back
  end

  private

  def congressman_params
    params.require(:congressman).permit(:name, :committee_id, :description, :party, :image, :image_cache)
  end
end
