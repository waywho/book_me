import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ 'time', 'detail' ];

  connect() {
    let showDelay, hideDelay;

    this.element.addEventListener('mouseenter', (event) => {
      clearTimeout(hideDelay);
      showDelay = setTimeout(() => { this.showDetails() }, 150);
    });

    this.element.addEventListener('mouseleave', (event) => {
      clearTimeout(showDelay);
      hideDelay = setTimeout(() => { this.hideDetails() }, 150);
    });
  }

  showDetails() {
    this.detailTargets.forEach(detail => detail.classList.remove("hidden"));
    this.timeTarget.classList.add("mt-3")
  }

  hideDetails() {
    this.detailTargets.forEach(detail => detail.classList.add("hidden"))
    this.timeTarget.classList.remove("mt-3")
  }
}
