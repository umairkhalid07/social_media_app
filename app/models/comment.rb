class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :text, presence: true

  default_scope { order(created_at: :asc) }

  after_create_commit { broadcast_append_to "comments", partial: "comments/comment", locals: { post: post }, target: "comments" }
  after_update_commit { broadcast_append_to "comments", partial: "comments/comment", locals: { post: post }, target: "comments" }
  after_destroy_commit { broadcast_append_to "comments", partial: "comments/comment", locals: { post: post }, target: "comments" }

end
