import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "result", "searchInput"];


  connect() {

    console.log(this.element);
    console.log(this.formTarget);
    console.log(this.resultTarget);
    console.log(this.searchInputTarget);
    console.log("Refresh List is connected")

    // The following disables the "enter" key in order prevent users from reloading the page.
    this.searchInputTarget.addEventListener("keypress", (event) => {
      if (event.key === "Enter") {
        event.preventDefault();
        this.submitForm();
      }
    });

    // To show the image initially
    const emptySearchImage = this.element.querySelector("#emptySearchImage");
    emptySearchImage.style.display = "block";
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`
    const searchInputValue = this.searchInputTarget.value.trim();
    const emptySearchImage = this.element.querySelector("#emptySearchImage");

    fetch(url, {
      headers: {
        'Accept': 'text/plain'
      }
    })
      .then(response => response.text())
      .then((data) => {
        this.resultTarget.outerHTML = data;

        //Checks after getting data to see if there are no search results
        //Checks if class "search_results" is used to create results list"
        const noResults = this.resultTarget.querySelectorAll(".search_results").length < 1;
        if (searchInputValue === "" || (searchInputValue !== "" && noResults)) {
          emptySearchImage.style.display = "block";
        } else {
          emptySearchImage.style.display = "none";
        }
      });
  }
}


// Original code just in case.

// import { Controller } from "@hotwired/stimulus";

// export default class extends Controller {
//   static targets = ["form", "result", "searchInput"];


//   connect() {
//     console.log(this.element);
//     console.log(this.formTarget);
//     console.log(this.resultTarget);
//     console.log(this.searchInputTarget);
//     console.log("Refresh List is connected")

//     // The following disables the "enter" key in order prevent users from reloading the page.
//     this.searchInputTarget.addEventListener("keypress", (event) => {
//       if (event.key === "Enter") {
//         event.preventDefault();
//         this.submitForm();
//       }
//     });
//   }



//   update() {
//     const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`
//     fetch(url, {
//       headers: {
//         'Accept': 'text/plain'
//       }
//     })
//       .then(response => response.text())
//       .then((data) => {
//         this.resultTarget.outerHTML = data;
//       })
//   }
// }
