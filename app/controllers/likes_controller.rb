class LikesController < ApplicationController
  def create
    @likable = find_likable
    @like = @likable.likes.build
    @like.user = current_user

    @like.save
    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @likable = @like.likable

    @like.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
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
