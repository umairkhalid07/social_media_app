class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }

  validates :text, presence: true

  has_one_attached :image
end
