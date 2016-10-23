class Congressman < ApplicationRecord
  belongs_to :committee
  has_many :matches, dependent: :destroy
  has_many :timelines, dependent: :destroy

  validates :name, presence: true

  # mount
  mount_uploader :image, ImageUploader

  # validations
  HTML_AT_NICKNAME_REGEX = /(?:^|\s|>)(@[ㄱ-ㅎ가-힣a-z0-9_]+)/
end
