import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "result", "searchInput"];


  connect() {
    console.log(this.element);
    console.log(this.formTarget);
    console.log(this.resultTarget);
    console.log(this.searchInputTarget);
    console.log("Refresh List is connected")

  }
  update() {
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`
    fetch(url, {
      headers: {
        'Accept': 'text/plain'
      }
    })
      .then(response => response.text())
      .then((data) => {
        this.resultTarget.outerHTML = data;
      })
  }
}
