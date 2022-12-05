class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :text, presence: true

  default_scope { order(created_at: :desc) }
end
