class Tag < ApplicationRecord
  has_many :vtuber_tags,dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、vtuber_tagsを通じて参照できる
  has_many :vtubers,through: :vtuber_tags



  validates :tag_name, uniqueness: true, presence: true
end
