// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This script is run blocking at the beginning of the page load to ensure that
// we don't have flashing white background before switching to dark mode.
(function () {
  if (!document.body.classList.contains('-experimental-dark-mode')) {
    return;
  }

  // Detects OS or browser-level theme preference by using media queries.
  let mediaPrefersDarkScheme = false;
  try {
    mediaPrefersDarkScheme =
      window.matchMedia('(prefers-color-scheme: dark)').matches;
  } catch (e) {
    // ignore errors e.g. when media query matching is not supported
  }

  // Detects whether the dartdoc control was set to use dark theme
  let dartdocDarkThemeIsSet = window.localStorage.getItem('colorTheme') == 'true';

  // Switch the top-level style marker to use dark theme instead of the light theme default.
  if (mediaPrefersDarkScheme || dartdocDarkThemeIsSet) {
    document.body.classList.remove('light-theme');
    document.body.classList.add('dark-theme');
  }
})();
