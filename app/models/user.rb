class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vtubers, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :favorite_vtubers, through: :favorites, source: :vtuber
  has_many :vtuber_comments, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy


  has_one_attached :profile_image

  validates :name, presence: true,length:{ minimum: 2, maximum: 20  },uniqueness: true
  validates :introduction, length: { maximum:30 }


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.looks(search, word)
    if search == "perfect"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end


end
