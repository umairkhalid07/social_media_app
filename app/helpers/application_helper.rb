module ApplicationHelper
  def render_flash_messages
    turbo_stream.update "flash", partial: "layouts/flash"
  end
end
