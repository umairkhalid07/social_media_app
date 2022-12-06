class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :text, presence: true

  default_scope { order(created_at: :desc) }

  after_create_commit { broadcast_append_to "posts"}
end
