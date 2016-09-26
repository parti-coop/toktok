class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :mentions, dependent: :destroy

  def mentioned?(congressman)
    mentions.exists?(congressman: congressman)
  end
end
