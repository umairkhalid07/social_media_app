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
  validate :check_future_date

  valid_phone_number_a = /^\+92\d{10}$/
  valid_phone_number_b = /^[0]\d{10}$/
  valid_phone_number = /#{valid_phone_number_a}|#{valid_phone_number_b}/
  validates :phone_number, format: { with: valid_phone_number }

  default_scope { order(name: :asc) }

  def remove_friend(user, friend)
    user.friends.destroy(friend)
  end

  private

  def check_future_date
    if birthday_at > Date.today
      errors.add(:birthday_at, "can't be in the future")
    end
  end
end
