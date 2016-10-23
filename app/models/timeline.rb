class Timeline < ApplicationRecord
  belongs_to :project
  belongs_to :congressman

  validates :body, presence: true
  validates :timeline_date, presence: true

  scope :recent, -> { order(timeline_date: :desc) }
  scope :oldest, -> { order(timeline_date: :asc) }

  # mount
  mount_uploader :image, ImageUploader
end
