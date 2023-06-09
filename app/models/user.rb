class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vtubers
  has_one_attached :profile_image
  # has_many :favorites,dependent: :destroy
  # has_many :book_comments,dependent: :destroy
  # has_many :favorites, dependent: :destroy
  # has_many :favorited_books, through: :favorites, source: :book


end
