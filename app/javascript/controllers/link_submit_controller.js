import Rails from "@rails/ujs";
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="link-submit"
export default class extends Controller {
  onPostSuccess() {

  }

  submit(e) {
    e.preventDefault();
    console.log(e.target)
    console.log(this.element)

    this.element.submit()
  }
}
