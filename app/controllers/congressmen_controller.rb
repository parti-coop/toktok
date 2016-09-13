class CongressmenController < ApplicationController
  def create
    @congressman = Congressman.new(congressman_params)
    @congressman.save
    redirect_to :back
  end

  def destroy
    @congressman = Congressman.find(params[:id])
    @congressman.destroy
    redirect_to :back
  end

  private

  def congressman_params
    params.require(:congressman).permit(:name, :committee_id)
  end
end