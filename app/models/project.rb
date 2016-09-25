class Project < ApplicationRecord
  belongs_to :proposal, required: false
  belongs_to :user
  belongs_to :committee
  has_many :likes, as: :likable
  has_many :comments, as: :commentable
  has_many :attachments, dependent: :destroy, as: :attachable
  has_many :participations, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :matched_congressmen, through: :matches, source: :congressman

  accepts_nested_attributes_for :attachments, reject_if: proc { |params| params[:source].blank? and params[:source_cache].blank? and params[:id].blank? }, allow_destroy: true

  def participant? someone
    participations.exists? user: someone
  end

  def status
    if participations_count < participations_goal_count
      :gathering
    elsif matches.having_status(:accept).any?
      :matched
    else
      :calling
    end
  end

  def unmathed_ongressmen
    Congressman.where.not(id: matched_congressmen)
  end
end
