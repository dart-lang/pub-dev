// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

window.dataLayer = window.dataLayer || [];
window.dataLayer.push({
  'gtm.start': new Date().getTime(),
  event: 'gtm.js'
});


// Setup listening to send Google Analytics events when any element
// with a 'data-ga-click-event' attribute is clicked.
window.addEventListener('DOMContentLoaded', function () {
  function sendEvent(e) {
    var hasModifierKey = (e.altKey == true) || (e.ctrlKey  == true) || (e.metaKey == true) || (e.shiftKey == true);
    var element = e.currentTarget;
    var customEvent = {
      event: 'custom-event',
      customEventCategory: 'click',
      customEventAction: element.dataset.gaClickEvent,
      customEventLabel: 'path:' + window.location.pathname,
      customEventValue: 1 
    };

    if (element.hasAttribute('href') && (!hasModifierKey)) {
      var done = false;
      // Change location after handling the event:
      // https://developers.google.com/tag-manager/enhanced-ecommerce
      customEvent.eventCallback = function () {
        if (!done) {
          done = true;
          document.location = element.href;
        }
      };
      e.preventDefault();
      // Fallback location change in case the Google Tag Manager is blocked.
      setTimeout(customEvent.eventCallback, 100);
    }

    // Push custom-event to GTM, which is configured to forward it to
    // Google Analytics.
    window.dataLayer.push(customEvent);    
  }
  function addListeners() {
    var elements = document.querySelectorAll('[data-ga-click-event]');
    for (var i = 0; i < elements.length; i++) {
      elements[i].addEventListener('click', sendEvent);
    }
  }
  addListeners();
});
