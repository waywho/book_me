import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ 'toggleInput' ];

  toggleDisable(e) {
    this.toggleInputTarget.disabled = e.target.checked
  }

  toggleVisibility(e) {
    document.querySelectorAll('[data-toggle]').forEach(e => {
      e.dataset.toggle = "hide"
    })

    document.getElementById(e.target.dataset.targetId).dataset.toggle = "show"
    document.querySelectorAll(".tab").forEach(e => {
      e.classList.remove("tab-active")
    })
    e.target.classList.add("tab-active")
  }
}
