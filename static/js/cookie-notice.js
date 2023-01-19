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

      var widget = document.createElement('div');
      widget.id = 'cookie-notice';
      var container = document.createElement('div');
      container.className = 'cookie-notice-container';
      widget.append(container);

      container.innerHTML = '<div><a href="https://pub.dev/">Pub.dev</a> uses cookies from Google to deliver and enhance the quality of its services and to analyze traffic. ' +
        '<a href="https://policies.google.com/technologies/cookies" target="_blank" rel="noopener">Learn more.</a>';
      var button = document.createElement('button');
      button.innerText = 'Ok, Got it.';
      button.className = 'cookie-notice-button';
      button.onclick = function (e) {
        widget.remove();

        try {
          // attempt to store in localStorage (if not disabled or full)
          var expiresAt = Date.now() + (maxAgeSeconds * 1000);
          localStorage.setItem('cookieNoticeExpiresAt', expiresAt.toString());
        } catch (e) {
          // do nothing - local storage may be disabled
        }
      };

      var buttonDiv = document.createElement('div');
      buttonDiv.append(button);
      container.append(buttonDiv);

      document.body.append(widget);
    }
  });
})();
