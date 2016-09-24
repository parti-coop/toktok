class Project < ApplicationRecord
  belongs_to :proposal, required: false
  belongs_to :user
  belongs_to :committee
  has_many :likes, as: :likable
  has_many :comments, as: :commentable
  has_many :attachments, dependent: :destroy, as: :attachable
  has_many :participations, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: proc { |params| params[:source].blank? and params[:source_cache].blank? and params[:id].blank? }, allow_destroy: true

  def participant? someone
    participations.exists? user: someone
  end
end
