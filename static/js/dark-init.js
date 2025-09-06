// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This script is run blocking at the beginning of the page load to ensure that
// we don't have flashing white background before switching to dark mode.
(function () {
  // Detects OS or browser-level theme preference by using media queries.
  let mediaPrefersDarkScheme = false;
  try {
    mediaPrefersDarkScheme =
      window.matchMedia('(prefers-color-scheme: dark)').matches;
  } catch (e) {
    // ignore errors e.g. when media query matching is not supported
  }

  // Detects whether the control widget was set to use a specific theme
  let colorTheme = window.localStorage.getItem('colorTheme');
  let lightThemeIsSet = colorTheme == 'false';
  let darkThemeIsSet = colorTheme == 'true';

  if (lightThemeIsSet) {
    // nothing to do here, the default style is the light-theme
  } else if (mediaPrefersDarkScheme || darkThemeIsSet) {
    // switch to the dark theme
    document.body.classList.remove('light-theme');
    document.body.classList.add('dark-theme');
  }

  document.body.classList.remove('loading-theme');
})();
