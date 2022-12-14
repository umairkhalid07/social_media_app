class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :text, presence: true

  default_scope { order(created_at: :asc) }

  after_create_commit { broadcast_append_to "posts", partial: "comments/comment", locals: { comment: self } }
  after_update_commit { broadcast_replace_to "posts", partial: "comments/comment", locals: { comment: self } }
  after_destroy_commit { broadcast_remove_to "posts", target: "comment_#{self.id}" }

end
