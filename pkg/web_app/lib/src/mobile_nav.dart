// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart';
import 'package:web_app/src/web_util.dart';

void setupMobileNav() {
  _setEventForMobileNav();
  _setEventForDetailMetadataToggle();
}

void _setEventForMobileNav() {
  // hamburger menu on mobile
  final hamburger = document.querySelector('.hamburger');
  final mask = document.querySelector('.site-header-mask') as HTMLElement?;
  final nav = document.querySelector('.site-header-nav') as HTMLElement?;

  final allElems = [nav, mask].nonNulls.toList();

  hamburger?.onClick.listen((_) {
    // This opacity hack enables smooth initialization, otherwise users would
    // see a rendering glitch with the content animating at the start.
    nav?.style.opacity = '1';
    allElems.forEach((e) => e.classList.add('-show'));
  });

  mask?.onClick.listen((_) {
    allElems.forEach((e) => e.classList.remove('-show'));
  });
}

void _setEventForDetailMetadataToggle() {
  // Stored x,y coordinate of the scroll position at the time of the opening of metadata.
  double? origX, origY;

  var isVisible = false;
  final titleElem = document.head?.querySelector('title') as HTMLElement?;
  final currentTitle = titleElem?.innerText.trim();
  final currentUrl = window.location.toString();

  Future<void> applyVisibility(bool visible) async {
    if (visible == isVisible) return;
    isVisible = visible;

    document.querySelector('.detail-wrapper')?.classList.toggle('-active');
    document.querySelector('.detail-metadata')?.classList.toggle('-active');
    await window.animationFrame;
    if (visible) {
      // store scroll position and scroll to the top
      origX = window.scrollX;
      origY = window.scrollY;
      window.scrollTo(0.toJS, 0);
    } else {
      // restore scroll position
      window.scrollTo((origX ?? 0).toJS, origY ?? 0);
      origX = null;
      origY = null;
    }
  }

  // Registered eagerly, not lazily on the first click, so a back-navigation
  // is never missed regardless of how long the open/close animation takes.
  window.onPopState.listen((event) async {
    final state = event.state.dartify();
    // only react on events that are relevant to this component
    if (state is Map &&
        state['type'] == 'detail-metadata' &&
        state['url'] == currentUrl) {
      await applyVisibility(state['visible'] == true);
    }
  });

  document.querySelectorAll('.detail-metadata-toggle').toElementList().forEach((
    e,
  ) {
    e.onClick.listen((_) {
      // when activating, set the current state to hide the view, and the next
      // state to activate the view
      if (!isVisible) {
        window.history.replaceState(
          {
            'type': 'detail-metadata',
            'url': currentUrl,
            'visible': false,
          }.jsify(),
          '',
          null,
        );
        window.history.pushState(
          {
            'type': 'detail-metadata',
            'url': currentUrl,
            'visible': true,
          }.jsify(),
          currentTitle ?? '',
          null,
        );
        unawaited(applyVisibility(true));
      } else {
        window.history.back();
      }
    });
  });
}
