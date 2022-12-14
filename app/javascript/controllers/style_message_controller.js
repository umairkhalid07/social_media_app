import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static values = { userid: String}
  connect() {
    console.log("Connected to style-message controller")

    const current_user_id = document.getElementById("current_user_id").dataset.userId
    const message_delete = this.element.querySelector('#message-delete')
    console.log(message_delete)
    const user_id = this.data.get("useridValue")
    console.log(current_user_id)
    console.log(user_id)
    console.log(current_user_id === user_id)

    if (current_user_id === user_id) {
      this.element.classList.add("sent-message");
      this.element.classList.remove("received-message");
      this.element.parentElement.classList.add("sent-message-container");
      this.element.parentElement.classList.remove("received-message-container");
      message_delete.style.display = "inline"
    } else {
        this.element.classList.add("received-message");
        this.element.classList.remove("sent-message");
        this.element.parentElement.classList.add("received-message-container");
        this.element.parentElement.classList.remove("sent-message-container");
        message_delete.style.display = "none";
    }
  }
}
