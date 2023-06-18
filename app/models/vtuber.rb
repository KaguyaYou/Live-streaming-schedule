class Vtuber < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :vtuber_comments, dependent: :destroy
  has_many :favorite_users, through: :vtubers_users, source: :user
  has_many :vtuber_tags,dependent: :destroy
  has_many :tags, through: :vtuber_tags
  has_one_attached :image


  def get_image(width, height)
    unless get_image.attached?
      file_path =Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename:'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    # byebug
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete
      Tag.find_by(tag_name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_vtuber_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_vtuber_tag
    end
  end

  def favorited_by?(user)
   user.present? && favorites.exists?(user_id: user.id)
  end



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
