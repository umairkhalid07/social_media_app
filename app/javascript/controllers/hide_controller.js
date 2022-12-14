import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static values = { userid: String}
  connect() {
    console.log("Connected to hide controller")

    const current_user_id = document.getElementById("current_user_id").dataset.userId
    const user_id = this.data.get("useridValue")

    if (current_user_id === user_id) {
      this.element.style.display = ""
    } else {
      this.element.style.display = "none"
    }
  }
}
