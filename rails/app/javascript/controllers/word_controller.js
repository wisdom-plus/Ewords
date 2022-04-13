import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="word"
export default class extends Controller {
  static targets = ["next"];
  static values = { answered: Boolean };

  next(event) {
    const answered = this.answeredValue;
    if (!answered) {
      const click_option = event.currentTarget;
      if (click_option.id === "correct") {
        click_option.classList.remove(
          "bg-white",
          "hover:bg-gray-100",
          "dark:border-gray-400",
          "dark:hover:bg-gray-500"
        );
        click_option.classList.add("bg-green-200", "dark:bg-green-300");
        this.set_session(true);
      } else {
        click_option.classList.remove(
          "bg-white",
          "hover:bg-gray-100",
          "dark:border-gray-400",
          "dark:hover:bg-gray-500"
        );
        click_option.classList.add("bg-red-200", "dark:bg-red-300");
        this.set_session(false);
      }
      this.remove_hidden();
      this.next_button();
      this.answeredValue = true;
    }
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

  set_session(answer) {
    const correct_answer = sessionStorage.getItem("correct_answer");
    if (correct_answer == null) {
      sessionStorage.setItem("correct_answer", answer);
    } else {
      const correct_answer_arr = correct_answer.split(",");
      correct_answer_arr.push(answer);
      const new_correct_answer = correct_answer_arr.join("");
      sessionStorage.setItem("correct_answer", new_correct_answer);
      console.log(new_correct_answer);
    }
  }
}
