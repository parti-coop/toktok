class Committee < ApplicationRecord
  has_many :congressmen

  validates :name, presence: true
end
