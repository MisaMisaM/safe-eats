import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="enty-thinner"
export default class extends Controller {
  static targets = ["details", "text"]
  connect() {
    console.log("Entry thinner is connected")
  }
  dropdown() {
    this.detailsTarget.classList.toggle("d-none")
    this.textTarget.classList.toggle("expanded-height")
  }
}
