class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true, counter_cache: true

  def self.liked_by?(likable, user)
    self.like_by_likable_and_user(likable, user).present?
  end

  def self.like_by_likable_and_user(likable, user)
    self.where(user: user, likable: likable).first
  end
end
