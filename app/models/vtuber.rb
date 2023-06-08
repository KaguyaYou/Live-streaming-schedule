class Vtuber < ApplicationRecord
  belongs_to:user
  # has_many :favorites,deoendent: :destroy
  # has_many :vtuber_comments,deoendent: :destroy
  # has_many :favorites,deoendent: :destroy
  # has_many :favorited_users,through: :favorites,source: :user
  # has_many :week_favorites, -> { where(created_at: ((Time.current.at_end _of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'

  has_one_attached :image

  def get_image(width, height)
    unless get_image.attached?
      file_path =Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename:'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  def favorited_by?(user)
   favorites.exists?(user?id:user.id)
  end
end
