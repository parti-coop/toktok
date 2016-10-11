class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :project, counter_cache: true

  validates :user, uniqueness: {scope: :project_id}

  scope :recent, -> { order(created_at: :desc) }
end
