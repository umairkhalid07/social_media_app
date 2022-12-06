class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :text, presence: true

  default_scope { order(created_at: :desc) }
end
