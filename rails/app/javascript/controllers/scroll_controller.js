import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="scroll"
export default class extends Controller {
  static targets = ["policy", "home"];

  policyTargetConnected() {
    const html = document.documentElement;
    html.classList.remove("overflow-hidden");
  }

  homeTargetConnected() {
    window.scroll({ top: 0, behavior: "smooth" });
    const html = document.documentElement;
    html.classList.add("overflow-hidden");
  }
}
