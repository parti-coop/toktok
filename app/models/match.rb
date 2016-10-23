class Match < ApplicationRecord
  extend Enumerize
  enumerize :status, in: [:calling, :accept, :reject], scope: :having_status

  belongs_to :project
  belongs_to :congressman

  scope :in_accept, -> { where(status: :accept) }
end
