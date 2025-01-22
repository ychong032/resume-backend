import { incrementVisitorCount } from "./visitorCount.js";

let updatedVisitorCount = await incrementVisitorCount();
const visitorCountElement = document.getElementById("visitor-counter");

let digits = updatedVisitorCount.toString().split("");
for (let digit of digits) {
    visitorCountElement.innerHTML += `<span class=\"bg-sky-300 rounded-md p-2 font-mono\">${digit}</span>`;
}
