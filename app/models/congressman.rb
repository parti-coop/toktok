class Congressman < ApplicationRecord
  belongs_to :committee

  validates :name, presence: true

  # mount
  mount_uploader :image, ImageUploader
end
