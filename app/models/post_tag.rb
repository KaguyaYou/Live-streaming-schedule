class PostTag < ApplicationRecord
  belongs_to :vtuber
  belongs_to :tag
  validates :post_id, presence: true
  validates :tag_id, presence: true
end
