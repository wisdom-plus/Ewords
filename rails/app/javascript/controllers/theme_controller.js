import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = ["body"];
  connect() {
    const body = this.bodyTarget;
    if (
      localStorage.theme === "dark" ||
      (!("theme" in localStorage) &&
        window.matchMedia("(prefers-color-scheme: dark)").matches)
    ) {
      body.classList.add("dark");
    } else {
      body.classList.remove("dark");
    }
  }

  next() {
    const body = this.bodyTarget;
    if (body.className === "dark") {
      body.classList.remove("dark");
      localStorage.setItem("theme", "light");
    } else {
      body.classList.add("dark");
      localStorage.setItem("theme", "dark");
    }
  }
}
