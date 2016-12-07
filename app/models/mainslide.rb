class Mainslide < ApplicationRecord
  validates :order, presence: true
  validates :image, presence: true
  # mount
  mount_uploader :image, ImageUploader
end
