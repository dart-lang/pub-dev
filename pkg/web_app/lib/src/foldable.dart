// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math' show min, max;

void setupFoldable() {
  _setEventForFoldable();
}

/// Elements with the `foldable` class provide a folding content:
///   - when the `foldable-button` is clicked, the `-active` class on `foldable` is toggled
///   - when the `foldable` is active, the `foldable-content` element is displayed.
void _setEventForFoldable() {
  for (final h in document.querySelectorAll('.foldable-button')) {
    final foldable = _parentWithClass(h, 'foldable');
    if (foldable == null) continue;

    final content = foldable.querySelector('.foldable-content');
    final scrollContainer = _parentWithClass(h, 'scroll-container');

    h.onClick.listen((e) async {
      // Toggle state.
      final isActive = foldable.classes.toggle('-active');

      // Closing is simple: no measurements, no scrolling.
      if (!isActive) {
        content.style.maxHeight = '0px';
        return;
      }

      /// The following coordinate and dimension measurements trigger a reflow,
      /// but it is acceptable, as it is local to this event processing and the
      /// impact is low.
      if (content.style.display != 'block') {
        content.style.display = 'block';
      }
      // Needs to be empty to measure real dimension.
      content.style.maxHeight = '';

      final contentHeight = content.offsetHeight;
      final boundingRect = content.getBoundingClientRect();
      final scrollContainerHeight = scrollContainer?.clientHeight;
      final buttonHeight = h.offsetHeight;

      // Reset content state as hidden.
      content.style.maxHeight = '0px';

      // Wait one animation frame before trigger the full height content.
      await window.animationFrame;
      content.style.maxHeight = '${contentHeight}px';

      num scrollDiff = 0;
      if (isActive && scrollContainer != null) {
        /// Calculate the required amount of scrolling in order to have the
        /// entire content in the view, aligning it at the bottom of the visible
        /// scroll view.
        final outsideViewDiff =
            boundingRect.top + boundingRect.height - scrollContainerHeight;

        /// Limit the maximum scrolling to the screen height minus the button
        /// component's height, in order to make sure it will be still visible
        /// after scrolling.
        final screenLimit = scrollContainerHeight - buttonHeight;

        /// Scroll the smaller amount of the two.
        scrollDiff = max(0, min(screenLimit, outsideViewDiff));
      }

      /// Do not scroll if the difference is small, otherwise scroll in small
      /// steps synchronized to the animation frames.
      if (scrollDiff > 8) {
        final originalScrollTop = scrollContainer.scrollTop;
        final maxSteps = 20;
        for (var i = 1; i <= maxSteps; i++) {
          if (i > 1) await window.animationFrame;
          final nextPos = originalScrollTop + (scrollDiff * i / maxSteps);
          scrollContainer.scrollTo(0, nextPos);
        }
      }
    });
  }
}

Element _parentWithClass(Element elem, String className) {
  while (elem != null) {
    if (elem.classes.contains(className)) return elem;
    elem = elem.parent;
  }
  return elem;
}
