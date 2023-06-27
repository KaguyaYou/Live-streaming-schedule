class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  has_many :chats
  validates :name, presence: true, uniqueness: true
  

  def profile_image_url
    if profile_image.present?
     file_path =Rails.root.join('app/assets/images/no_image.jpg')
    else
      image.attach(io: File.open(file_path), filename:'no_image.jpg', content_type: 'image/jpeg')
    end
  end
end
