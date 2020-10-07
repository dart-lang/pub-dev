// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

window.dataLayer = window.dataLayer || [];
window.dataLayer.push({
  'gtm.start': new Date().getTime(),
  event: 'gtm.js'
});

function gtag() { dataLayer.push(arguments); }

// Setup listening to send Google Analytics events when any element
// with a 'data-ga-click-event' attribute is clicked.
window.addEventListener('DOMContentLoaded', function () {
  function sendEvent(e) {
    var elem = e.currentTarget;

    var data = {
      'event_category': 'click',
      'event_label': 'path:' + window.location.pathname,
      'value': 1
    };

    // Events on links should be sent via beacon, see:
    // https://support.google.com/analytics/answer/7478520?hl=en
    if (elem.hasAttribute('href')) {
      var updated = false;
      var callbackFn = function () {
        if (updated) return;
        updated = true;
        document.location = elem.href;
      };
      data.event_callback = callbackFn;
      data.transport_type = 'beacon';
      e.preventDefault();

      // Fallback location change in case the Google Tag Manager is blocked.
      setTimeout(callbackFn, 100);
    }

    gtag('event', elem.dataset.gaClickEvent, data);
  }
  function addListeners() {
    var elements = document.querySelectorAll('[data-ga-click-event]');
    for (var i = 0; i < elements.length; i++) {
      elements[i].addEventListener('click', sendEvent);
    }
  }
  addListeners();
});
