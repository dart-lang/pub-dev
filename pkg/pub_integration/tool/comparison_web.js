const imageDivs = document.querySelectorAll('div.image');

imageDivs.forEach(function(div) {
  div.addEventListener('click', function() {
    this.classList.toggle('row');
  });
});
