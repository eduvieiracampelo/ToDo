const Theme = {
  init() {
    this.theme = localStorage.getItem("theme") || (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light");
    this.apply();
  },

  toggle() {
    this.theme = this.theme === "dark" ? "light" : "dark";
    localStorage.setItem("theme", this.theme);
    this.apply();
  },

  apply() {
    if (this.theme === "dark") {
      document.documentElement.classList.add("dark");
    } else {
      document.documentElement.classList.remove("dark");
    }
  }
};

document.addEventListener("DOMContentLoaded", () => Theme.init());

document.addEventListener("turbo:load", () => Theme.init());