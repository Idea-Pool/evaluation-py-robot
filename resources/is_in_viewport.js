/*
 * Obtained from: https://gomakethings.com/how-to-test-if-an-element-is-in-the-viewport-with-vanilla-javascript/
 * And updated to handle partial containment.
 */
var isInViewport = function (elem) {
    if (typeof elem === "string") {
        elem = document.querySelector(elem.replace("css:", ""))
    }
    var bounding = elem.getBoundingClientRect();
    var top = 0, bottom = window.innerHeight || document.documentElement.clientHeight;
    var left = 0, right = window.innerWidth || document.documentElement.clientWidth;
    return (
      (bounding.top >= top && bounding.top < bottom) ||
      (bounding.bottom > top && bounding.bottom <= bottom)
    ) && (
      (bounding.left >= left && bounding.left < right) ||
      (bounding.right > left && bounding.right <= right)
    );
};
