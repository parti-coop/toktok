class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :mentions, dependent: :destroy

  validates :body, presence: true

  def mentioned?(congressman)
    mentions.exists?(congressman: congressman)
  end
end
