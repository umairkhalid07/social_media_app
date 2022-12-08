class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :text, presence: true

  default_scope { order(created_at: :asc) }
end
