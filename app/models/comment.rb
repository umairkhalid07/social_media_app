class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :text, presence: true

  default_scope { order(created_at: :asc) }

  after_create_commit { broadcast_prepend_to "comments_post_#{self.post.id }", partial: "comments/comment", locals: { post: self.post, comment: self } }
  after_update_commit { broadcast_replace_to "comments_post_#{self.post.id }", partial: "comments/comment", locals: { post: self.post, comment: self } }
  after_destroy_commit { broadcast_remove_to "comments_post_#{self.post.id }", target: "comment_#{self.id}" }

end
