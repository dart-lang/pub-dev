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
  // ignore: cancel_subscriptions
  StreamSubscription<void>? stateSubscription;
  final titleElem = document.head?.querySelector('title') as HTMLElement?;
  final currentTitle = titleElem?.innerText.trim();
  final currentUrl = window.location.toString();
  document.querySelectorAll('.detail-metadata-toggle').toElementList().forEach((
    e,
  ) {
    e.onClick.listen((_) async {
      Future<void> toggle() async {
        isVisible = !isVisible;

        document.querySelector('.detail-wrapper')?.classList.toggle('-active');
        document.querySelector('.detail-metadata')?.classList.toggle('-active');
        await window.animationFrame;
        if (origX == null) {
          // store scroll position and scroll to the top
          origX = window.scrollX;
          origY = window.scrollY;
          window.scrollTo(0.toJS, 0);
        } else {
          // restore scroll position
          window.scrollTo(origX!.toJS, origY!);
          origX = null;
        }
      }

      // when activating, set the current state to hide the view, and the next
      // state to activate  the view
      if (!isVisible) {
        await toggle();
        window.history.replaceState(
          {
            'type': 'detail-metadata',
            'url': currentUrl,
            'visible': false,
          }.toJSBox,
          '',
          null,
        );
        window.history.pushState(
          {
            'type': 'detail-metadata',
            'url': currentUrl,
            'visible': true,
          }.toJSBox,
          currentTitle ?? '',
          null,
        );
      } else {
        window.history.back();
      }

      // only listen to state events after the first initialization
      stateSubscription ??= window.onPopState.listen((event) async {
        final state = event.state is Map ? event.state as Map : null;
        // only react on events that are relevant to this component
        if (state is Map &&
            state['type'] == 'detail-metadata' &&
            state['url'] == currentUrl) {
          final shouldBeVisible = state['visible'] == true;
          if (shouldBeVisible != isVisible) {
            await toggle();
          }
        }
      });
    });
  });
}
