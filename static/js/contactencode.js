 var encEmail = "bWF0dGhldy5oYW1pbHRvbkBvcnlnZW4ub3JnLmF1";
 const form = document.getElementById("contact");
 form.setAttribute("href", "mailto:".concat(atob(encEmail)));