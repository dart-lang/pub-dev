// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void setupMobileNav() {
  _setEventForMobileNav();
}

void _setEventForMobileNav() {
  // hamburger menu on mobile
  final Element hamburger = document.querySelector('.hamburger');
  final Element close = document.querySelector('.close');
  final Element mask = document.querySelector('.mask');
  final Element nav = document.querySelector('.nav-wrap');

  hamburger.onClick.listen((_) {
    nav.classes.add('-show');
    mask.classes.add('-show');
  });
  close.onClick.listen((_) {
    nav.classes.remove('-show');
    mask.classes.remove('-show');
  });
  mask.onClick.listen((_) {
    nav.classes.remove('-show');
    mask.classes.remove('-show');
  });
}
