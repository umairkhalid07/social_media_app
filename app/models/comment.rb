class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :text, presence: true
  after_update_commit { broadcast_replace_to "comments"}

  default_scope { order(created_at: :asc) }
end
