class Vtuber < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :vtuber_comments, dependent: :destroy
  has_many :vtubers_users, dependent: :destroy
  has_many :favorite_users, through: :vtubers_users, source: :user
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags
  has_one_attached :image


  def get_image(width, height)
    unless get_image.attached?
      file_path =Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename:'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  def favorited_by?(user)
   user.present? && favorites.exists?(user_id: user.id)
  end

  validates :category, presence: true

  def self.looks(search, word)
    if search == "perfect_match"
      @vtuber = Vtuber.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @vtuber = Vtuber.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @vtuber = Vtuber.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @vtuber = Vtuber.where("title LIKE?","%#{word}%")
    else
      @vtuber = Vtuber.all
    end
  end
end
