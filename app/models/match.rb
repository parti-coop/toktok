class Match < ApplicationRecord
  extend Enumerize
  enumerize :status, in: [:calling, :accept, :reject, :no_answer], scope: :having_status

  belongs_to :project
  belongs_to :congressman
end
