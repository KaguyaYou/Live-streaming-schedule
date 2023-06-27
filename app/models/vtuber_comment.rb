class VtuberComment < ApplicationRecord
  belongs_to :user
  belongs_to :vtuber
  validates :comment, presence: true,length:{ minimum: 2, maximum: 60 },uniqueness: true

end
