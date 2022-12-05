class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_one_attached :profile_photo
  has_many :posts, dependent: :destroy
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :reactions, dependent: :destroy

  validates :name, :phone_number, :bio, :location, :birthday_at, :email, :profile_photo, presence: true
  validates :email, :phone_number, uniqueness: true
  validates :bio, length: { minimum: 15 }
  validates :phone_number, length: { is: 11 }

  default_scope { order(name: :asc) }

  def remove_friend(user, friend)
    user.friends.destroy(friend)
  end
end
