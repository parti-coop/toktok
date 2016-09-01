class LikesController < ApplicationController
  def create
    @likable = find_likable
    @like = @likable.likes.build
    @like.user = current_user

    @like.save
    redirect_to :back
  end

  def destroy
    @like = Like.find(params[:id])

    @like.destroy
    redirect_to :back
  end

  private

  def find_likable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end
end