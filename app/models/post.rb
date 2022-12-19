class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_rich_text :content
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true

  default_scope { order(created_at: :desc) }

  after_create_commit { broadcast_prepend_to "posts", partial: "posts/post", locals: { post: self } }
  after_update_commit { broadcast_replace_to "posts", partial: "posts/post", locals: { post: self } }
  after_destroy_commit { broadcast_remove_to "posts", target: "post_#{self.id}" }
end
