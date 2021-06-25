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
  final hamburger = document.querySelector('.hamburger');
  final mask = document.querySelector('.site-header-mask');
  final nav = document.querySelector('.site-header-nav');

  final allElems = [nav, mask].where((e) => e != null).cast<Element>().toList();

  hamburger?.onClick.listen((_) {
    // This opacity hack enables smooth initialization, otherwise users would
    // see a rendering glitch with the content animating at the start.
    nav?.style.opacity = '1';
    allElems.forEach((e) => e.classes.add('-show'));
  });

  mask?.onClick.listen((_) {
    allElems.forEach((e) => e.classes.remove('-show'));
  });
}

void _setEventForDetailMetadataToggle() {
  // Stored x,y coordinate of the scroll position at the time of the opening of metadata.
  int? origX, origY;

  document.querySelectorAll('.detail-metadata-toggle').forEach((e) {
    e.onClick.listen((_) async {
      document.querySelector('.detail-wrapper')?.classes.toggle('-active');
      document.querySelector('.detail-metadata')?.classes.toggle('-active');
      await window.animationFrame;
      if (origX == null) {
        // store scroll position and scroll to the top
        origX = window.scrollX;
        origY = window.scrollY;
        window.scrollTo(0, 0);
      } else {
        // restore scroll position
        window.scrollTo(origX, origY);
        origX = null;
      }
    });
  });
}
