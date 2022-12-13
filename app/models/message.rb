class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id

  # after_create_commit { broadcast_append_to(partial: "conversations/chat", target: 'messages')  }
end
