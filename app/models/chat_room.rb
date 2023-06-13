class ChatRoom < ApplicationRecord
  has_many :messages
  has_and_belongs_to_many :users, through: :chat_users, dependent: :destroy
  has_many :chat_users, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
