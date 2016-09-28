class Proposal < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likable
  has_many :attachments, dependent: :destroy, as: :attachable
  has_many :projects

  validates :title, presence: true
  validates :proposer_name, presence: true
  validates :proposer_email, presence: true
  validates :proposer_phone, presence: true

  accepts_nested_attributes_for :attachments, reject_if: proc { |params| params[:source].blank? and params[:source_cache].blank? and params[:id].blank? }, allow_destroy: true

  def launched?
    projects.any?
  end

  def propose_image_url(version = nil)
    if user.present?
      if version.nil?
        return user.image.url
      else
        return user.image.send(version).url
      end
    end
    return UserImageUploader.new.default_url
  end
end
