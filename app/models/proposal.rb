class Proposal < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likable
  has_many :attachments, dependent: :destroy, as: :attachable
  has_many :projects

  accepts_nested_attributes_for :attachments, reject_if: proc { |params| params[:source].blank? and params[:source_cache].blank? and params[:id].blank? }, allow_destroy: true


  def launched?
    projects.any?
  end
end
