class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :text, presence: true
  validates :text, length: { minimum: 5 }

  default_scope { order(created_at: :desc) }

  # after_destroy_commit { broadcast_remove_to 'posts'}
end
