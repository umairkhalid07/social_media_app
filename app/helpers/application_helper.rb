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
    conversation = Conversation.where(sender_id: user1.id, receiver_id: user2.id).or(Conversation.where(sender_id: user2.id, receiver_id: user1.id))
    conversation.first
  end

  def current_path(path)
    "current" if current_page?(path)
  end

  def show_turbo_notice
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end
end
