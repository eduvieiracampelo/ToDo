import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toast"]

  connect() {
    requestAnimationFrame(() => {
      this.toastTarget.classList.remove("translate-y-full", "opacity-0")
      this.toastTarget.classList.add("translate-y-0", "opacity-100")
    })
    
    this.timer = setTimeout(() => this.hide(), 4000)
  }

  hide() {
    this.toastTarget.classList.add("translate-y-full", "opacity-0")
    this.toastTarget.classList.remove("translate-y-0", "opacity-100")
    setTimeout(() => this.element.remove(), 300)
  }

  close() {
    this.hide()
  }
}