import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="word"
export default class extends Controller {
  next(event) {
    const click_option = event.currentTarget;
    if (click_option.id === "correct") {
      console.log(click_option);
    } else {
      console.log(click_option);
    }
    this.remove_hidden();
  }

  remove_hidden() {
    const icon = document.querySelectorAll(".mark_icon");
    icon.forEach(function (value) {
      value.classList.remove("hidden");
    });
  }
}
