class Committee < ApplicationRecord
  has_many :congressmen
  has_and_belongs_to_many :projects, join_table: :assigned_committees

  validates :name, presence: true
end
