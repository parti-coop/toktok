class Mention < ApplicationRecord
  AT_REGEX = /(?:^|\s)@([ㄱ-ㅎ가-힣a-z0-9_]+)/

  belongs_to :congressman
  belongs_to :comment
end
