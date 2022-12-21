class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_one_attached :profile_photo
  has_many :posts, dependent: :destroy
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :conversations, :foreign_key => :sender_id, dependent: :destroy
  has_many :messages, through: :conversations, dependent: :destroy

  validates :name, :phone_number, :bio, :location, :birthday_at, :email, :profile_photo, presence: true
  validates :email, :phone_number, uniqueness: true
  validates :bio, length: { minimum: 20 }

  valid_phone_number_a = /\d{1,2}:\d{2}/
  valid_phone_number_b = /\d{1,2}:\d{2}/
  validates :phone_number, length: { is: 12 }

  default_scope { order(name: :asc) }

  def remove_friend(user, friend)
    user.friends.destroy(friend)
  end
end
