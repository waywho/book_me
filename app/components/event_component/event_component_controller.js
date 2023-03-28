import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ 'detail' ];

  connect() {
    this.element.addEventListener('mouseleave', (event) => {
      this.hideDetails();
    });
  }

  showDetails() {
    this.detailTargets.forEach(detail => detail.classList.remove("hidden"));
  }

  hideDetails() {
    this.detailTargets.forEach(detail => detail.classList.add("hidden"))
  }

  expand() {
    this.showDetails()
  }
}
