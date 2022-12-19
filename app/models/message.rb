class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id

  after_create_commit { broadcast_append_to "messages", partial: "messages/message", locals: { message: self } }
  after_destroy_commit { broadcast_remove_to "messages", target: "message_#{self.id}" }
end
