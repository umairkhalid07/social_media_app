class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self
  validate :not_friends
  validate :not_pending

  def accept
    user.friends << friend
    destroy
  end

  def not_self
    errors.add(:friend,"Cant send yourself a friend request") if user == friend
  end

  def not_friends
    errors.add(:friend,'User is already added') if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'You have already requested friendship') if friend.pending_friends.include?(user)
  end
end
