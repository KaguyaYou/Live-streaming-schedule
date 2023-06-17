class PostTag < ApplicationRecord
  belongs_to :vtuber
  belongs_to :tag
  
end
