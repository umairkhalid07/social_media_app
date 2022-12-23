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
    errors.add(:friend,"is yourself") if user == friend
  end

  def not_friends
    errors.add(:friend,'is already added') if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'has already been requested') if friend.pending_friends.include?(user)
  end
end
