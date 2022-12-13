class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id

  # after_create_commit { broadcast_append_to "messages", partial: "messages/message", locals: { conversation: conversation}, target: "messages" }
  # after_update_commit { broadcast_update_to "messages", partial: "messages/message", locals: { conversation: conversation}, target: "messages" }
  # after_destroy_commit { broadcast_replace_to "messages", partial: "messages/message", locals: { conversation: conversation}, target: "messages" }

end
