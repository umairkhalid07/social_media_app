module ApplicationHelper
  def render_flash_messages
    turbo_stream.update "flash", partial: "layouts/flash"
  end

  def get_likes(post)
    post.reactions.where(reaction_type: true).count
  end

  def get_dislikes(post)
    post.reactions.where(reaction_type: false).count
  end

  def find_conversation(user1, user2)
    conversation = Conversation.find_by(sender_id: user1.id, receiver_id: user2.id)
    if conversation.nil?
      conversation = Conversation.find_by(sender_id: user2.id, receiver_id: user1.id)
    end
    return conversation
  end
end
