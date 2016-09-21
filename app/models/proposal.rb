class Proposal < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likable
  has_many :proposal_attachments, dependent: :destroy

  accepts_nested_attributes_for :proposal_attachments, reject_if: proc { |params| params[:source].blank? and params[:source_cache].blank? and params[:id].blank? }, allow_destroy: true
end
