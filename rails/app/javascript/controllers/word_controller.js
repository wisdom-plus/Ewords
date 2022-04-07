import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="word"
export default class extends Controller {
  next(event) {
    const option = event.currentTarget;
    if (option.id === "correct") {
      console.log("OK");
    } else {
      console.log("miss");
    }
  }
}
