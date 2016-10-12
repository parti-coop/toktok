class Match < ApplicationRecord
  extend Enumerize
  enumerize :status, in: [:calling, :accept, :reject], scope: :having_status

  belongs_to :project
  belongs_to :congressman

  def translation(status)
    if status == 'calling'
      return '대기'
    elsif status == 'accept'
      return '응답'
    else
      return '거부'
    end
  end
end
