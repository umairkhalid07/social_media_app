import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static values = { userid: String}
  connect() {
    const currentUserId = document.getElementById("current_user_id").dataset.userId
    const userId = this.data.get("useridValue")

    if (currentUserId === userId) {
      this.element.classList.add("d-block")
      this.element.classList.remove("d-none")
    } else {
      this.element.classList.add("d-none")
      this.element.classList.remove("d-block")
    }
  }
}
