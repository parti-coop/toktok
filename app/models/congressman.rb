class Congressman < ApplicationRecord
  belongs_to :committee

  validates :name, presence: true
end
