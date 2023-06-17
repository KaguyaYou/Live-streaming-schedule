class VtuberTag < ApplicationRecord
  belongs_to :vtuber, optional: true
  belongs_to :tag, optional: true
  validates :vtuber_id, presence: true
  validates :tag_id, presence: true
end
