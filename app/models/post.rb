class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :image
  has_many :reactions, dependent: :destroy

  validates :text, presence: true

  default_scope { order(created_at: :asc) }
end
