class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates :name, :phone_number, :bio, :location, :birthday_at, :email, :profile_photo, presence: true
  validates :email, :phone_number, uniqueness: true
  validates :bio, length: { minimum: 15 }
  validates :phone_number, length: { is: 11 }

  has_one_attached :profile_photo

  has_many :posts, dependent: :destroy

  has_many :friend_requests_as_requestor, foreign_key: :requestor_id, class_name: :FriendRequest
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: :FriendRequest

  has_many :friendships, ->(user) { where("friend_a_id = ? OR friend_b_id = ?", user.id, user.id) }
  has_many :friends, through: :friendships
end
