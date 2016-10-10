class Comment < ApplicationRecord
  paginates_per 7

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :mentions, dependent: :destroy
  has_many :likes, as: :likable

  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :hottest, -> { where("likes_count >= 1").order(likes_count: :desc).limit(3) }
  def mentioned?(congressman)
    mentions.exists?(congressman: congressman)
  end
end
