var scrollByPage = function (n) {
  var height = window.innerHeight || document.documentElement.clientHeight;
  document.documentElement.scrollTop += (n || 1) * height;
};