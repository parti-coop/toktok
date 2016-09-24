class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :project, counter_cache: true

  scope :recent, -> { order(created_at: :desc) }
end
