class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def index
    @commentable = params[:commentable_type].classify.constantize.find(params[:commentable_id])
    @comments = @commentable.comments.recent.page(params[:page])
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if current_user.blank?
      redirect_to join_path
    else
      scan_mentioned_congressmen(@comment).each do |congressman|
        @comment.mentions.build(congressman: congressman)
      end
      errors_to_flash(@comment) unless @comment.save
      redirect_back_with_anchor anchor: 'anchor-comments', fallback_location: @comment.commentable
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.assign_attributes(comment_params)
    mentioned_congressmen = scan_mentioned_congressmen(@comment)

    @comment.mentions.each do |mention|
      mention.destroy unless mentioned_congressmen.include? mention.congressman
    end
    mentioned_congressmen.each do |congressman|
      @comment.mentions.build(congressman: congressman) unless @comment.mentioned? congressman
    end
    @comment.save
    redirect_to @comment.commentable
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    errors_to_flash(@comment) unless @comment.destroy
    redirect_back fallback_location: @comment.commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end

  def scan_mentioned_congressmen(comment)
    parse_mention_sign(comment.body).map { |name| Congressman.find_by(name: name) }.compact
  end

  def parse_mention_sign(body)
    body.scan(Mention::AT_REGEX).flatten.compact.uniq
  end
end
