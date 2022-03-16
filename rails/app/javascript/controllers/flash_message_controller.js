import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="flash-message"
export default class extends Controller {
  static targets = ["message"];
  next() {
    const messageHTML = this.messageTarget;
    messageHTML.remove();
  }
}
