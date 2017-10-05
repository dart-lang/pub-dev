(function(){
  // global variable for tabs
  let tabs, content;

  // init once the dom is ready
  if (document.readyState !== "loading") {
    init();
  } else {
    document.addEventListener("DOMContentLoaded", init);
  }

  function init(){
    setEventForTabs();
    setEventForAnchorScroll();
    setEventForMobileNav();
    changeTabOnUrlHash();
  }

  function setEventForTabs(){
    tabs = document.querySelector('.js-tabs');
    content = document.querySelectorAll('.js-content');

    if (tabs && content.length) {
      tabs.addEventListener('click', (e) => {
        // locate the <li> tag
        let target = e.target;
        while(target.tagName !== 'LI' && target.tagName !== 'BODY'){
          target = target.parentElement;
        }
        const name = target.dataset.name;
        if (name) {
          changeTab(name);
          location.hash = '#' + target.dataset.name;
        }
      });
    }
  }

  function setEventForAnchorScroll(){
    // scroll to the anchor when clicking on a anchor link in the markdown
    const container = document.querySelector('.markdown-body');
    if (container) {
      container.addEventListener('click', function(e){
        // locate the <a> tag
        let target = e.target;
        while(target.tagName !== 'A' && target.tagName !== 'BODY'){
          target = target.parentElement;
        }
        if (target.host === location.host && target.hash) {
          e.preventDefault()
          const elem = document.querySelector(target.hash);
          if (elem) {scrollTo(document.body, elem.offsetTop - 80, 300);}
        }
      });
    }
  }

  function setEventForMobileNav(){
    // hamburger menu on mobile
    const hamburger = document.querySelector('.hamburger')
    const close = document.querySelector('.close');
    const mask = document.querySelector('.mask');
    const nav = document.querySelector('.nav-wrap');

    hamburger.addEventListener('click', () => {
      nav.classList.add('-show');
      mask.classList.add('-show');
    });
    close.addEventListener('click', () => {
      nav.classList.remove('-show');
      mask.classList.remove('-show');
    });
    mask.addEventListener('click', () => {
      nav.classList.remove('-show');
      mask.classList.remove('-show');
    });
  }

  function changeTabOnUrlHash(){
    // change the tab based on URL hash
    if (tabs && location.hash){
      changeTab(location.hash.slice(1));
    }
  }

  function changeTab(name){
    if (tabs.querySelector('[data-name=' + name + ']')){
      // toggle tab highlights
      Array.prototype.slice.call(tabs.children).forEach(node => {
        if (node.dataset.name !== name) node.classList.remove('-active');
        else node.classList.add('-active');
      })

      // toggle content
      content.forEach(node => {
        if (node.dataset.name !== name) node.classList.remove('-active');
        else node.classList.add('-active');
      })
    }
  }

  function scrollTo(element, to, duration) {
    if (duration <= 0) return;
    var difference = to - element.scrollTop;
    var perTick = difference / duration * 10;

    setTimeout(function() {
      element.scrollTop = element.scrollTop + perTick;
      if (element.scrollTop === to) return;
      scrollTo(element, to, duration - 10);
    }, 10);
  }
})()
