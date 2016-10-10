class Congressman < ApplicationRecord
  belongs_to :committee
  has_many :matches, dependent: :destroy

  validates :name, presence: true

  # mount
  mount_uploader :image, ImageUploader
end
