// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void setupMobileNav() {
  _setEventForMobileNav();
  _setEventForDetailMetadataToggle();
}

void _setEventForMobileNav() {
  // hamburger menu on mobile
  final Element hamburger = document.querySelector('.hamburger');
  final Element close = document.querySelector('.close');
  final Element mask = document.querySelector('.mask');
  final Element nav = document.querySelector('.nav-wrap');
  final newMask = document.querySelector('.site-header-mask');
  final newNav = document.querySelector('.site-header-nav');

  final allElems =
      [nav, mask, newNav, newMask].where((e) => e != null).toList();

  hamburger.onClick.listen((_) {
    // This opacity hack enables smooth initialization, otherwise users would
    // see a rendering glitch with the content animating at the start.
    newNav?.style?.opacity = '1';
    allElems.forEach((e) => e.classes.add('-show'));
  });

  // TODO: remove after new design is deployed
  close?.onClick?.listen((_) {
    allElems.forEach((e) => e.classes.remove('-show'));
  });

  // TODO: remove after new design is deployed
  mask?.onClick?.listen((_) {
    allElems.forEach((e) => e.classes.remove('-show'));
  });

  // TODO: remove `?` after new design is deployed
  newMask?.onClick?.listen((_) {
    allElems.forEach((e) => e.classes.remove('-show'));
  });
}

void _setEventForDetailMetadataToggle() {
  document.querySelectorAll('.detail-metadata-toggle').forEach((e) {
    e.onClick.listen((_) {
      document.querySelector('.detail-wrapper')?.classes?.toggle('-active');
      document.querySelector('.detail-metadata')?.classes?.toggle('-active');
    });
  });
}
