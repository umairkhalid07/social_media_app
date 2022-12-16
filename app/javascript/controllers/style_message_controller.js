import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static values = { userid: String}
  connect() {
    const currentUserId = document.getElementById("current_user_id").dataset.userId
    const messageDelete = this.element.querySelector('#message-delete')
    const userId = this.data.get("useridValue")

    if (currentUserId === userId) {
        toggle(this.element, "sent-message", "received-message")
        toggle(this.element, "sent-message-container", "received-message-container")
        toggle(messageDelete, "d-inline", "d-none")
    } else {
        toggle(this.element, "received-message", "sent-message")
        toggle(this.element, "received-message-container", "sent-message-container")
        toggle(messageDelete, "d-none", "d-inline")
    }
  }
    toggle(element, class1, class2) {
        element.classList.add(class1)
        element.classList.remove(class2)
    }
}
