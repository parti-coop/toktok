class Mainslide < ApplicationRecord
  validates :order, presence: true
  validates :image, presence: true
  # mount
  mount_uploader :image, ImageUploader

  scope :priority, -> { order(order: :asc) }
  scope :recent, -> { order(created_at: :desc) }
  scope :sequential, -> { order(created_at: :asc) }
end
