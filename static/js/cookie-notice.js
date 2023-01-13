// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This script displays a cookie notice widget at the bottom of the screen.
(function () {
  var initialized = false;
  var maxAgeSeconds = 30 * 24 * 60 * 60; // 30 days
  document.addEventListener('DOMContentLoaded', function () {
    // Run only once.
    if (!initialized) {
      initialized = true;

      // check accepted notice
      try {
        var storedExpiresAt = localStorage.getItem('cookieNoticeExpiresAt');
        if (storedExpiresAt === undefined || storedExpiresAt === null) {
          // no value - do nothing
        } else if (storedExpiresAt > Date.now()) {
          // the value is in the future, we don't need to display the notice widget
          return;
        }
      } catch (e) {
        // do nothing - local storage may be disabled
      }
      // Fallback: check if the cookie is set.
      if (document.cookie.split('; ').includes('notice=1')) {
        return;
      }

      var widget = document.createElement('div');
      widget.id = 'cookie-notice';
      var container = document.createElement('div');
      container.className = 'cookie-notice-container';
      widget.append(container);

      container.innerHTML = '<div>Google uses cookies to deliver its services, to personalize ads, and to analyze traffic. ' +
        'You can adjust your privacy controls anytime in your <a href="https://myaccount.google.com/data-and-personalization" target="_blank" rel="noopener">Google settings</a>. ' +
        '<a href="https://policies.google.com/technologies/cookies" target="_blank" rel="noopener">Learn more</a>.</div>';
      var button = document.createElement('button');
      button.innerText = 'Okay';
      button.className = 'cookie-notice-button';
      button.onclick = function (e) {
        widget.remove();

        try {
          // attempt to store in localStorage (if not disabled or full)
          var expiresAt = Date.now() + (maxAgeSeconds * 1000);
          localStorage.setItem('cookieNoticeExpiresAt', expiresAt.toString());
        } catch (e) {
          // fallback: set a cookie
          document.cookie = 'notice=1;max-age=' + maxAgeSeconds.toString() + ';path=/';
        }
      };

      var buttonDiv = document.createElement('div');
      buttonDiv.append(button);
      container.append(buttonDiv);

      document.body.append(widget);
    }
  });
})();
