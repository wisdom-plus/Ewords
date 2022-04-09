import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="word"
export default class extends Controller {
  static targets = ["next"];

  next(event) {
    const click_option = event.currentTarget;
    if (click_option.id === "correct") {
      click_option.classList.remove(
        "hover:bg-gray-100",
        "dark:border-gray-400",
        "dark:hover:bg-gray-500"
      );
      click_option.classList.add("bg-green-200", "dark:bg-green-300");
    } else {
      click_option.classList.remove(
        "hover:bg-gray-100",
        "dark:border-gray-400",
        "dark:hover:bg-gray-500"
      );
      click_option.classList.add("bg-red-200", "dark:bg-red-300");
    }
    this.remove_hidden();
    this.next_button();
  }

  remove_hidden() {
    const icon = document.querySelectorAll(".mark_icon");
    icon.forEach(function (value) {
      value.classList.remove("hidden");
    });
  }

  next_button() {
    const next_button = this.nextTarget;
    next_button.classList.remove("hidden");
  }
}
