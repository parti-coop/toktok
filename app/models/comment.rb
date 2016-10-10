class Comment < ApplicationRecord
  paginates_per 10

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :mentions, dependent: :destroy
  has_many :likes, as: :likable

  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def mentioned?(congressman)
    mentions.exists?(congressman: congressman)
  end
end
