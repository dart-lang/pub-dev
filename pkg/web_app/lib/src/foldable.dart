// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math' show min, max;

void setupFoldable() {
  _setEventForFoldable();
  _setEventForCheckboxToggle();
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
    if (content == null) continue;

    Future<void> update(bool isActive) async {
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
      if (scrollContainer != null) {
        /// Calculate the required amount of scrolling in order to have the
        /// entire content in the view, aligning it at the bottom of the visible
        /// scroll view.
        final outsideViewDiff =
            boundingRect.top + boundingRect.height - scrollContainerHeight!;

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
        final originalScrollTop = scrollContainer!.scrollTop;
        final maxSteps = 20;
        for (var i = 1; i <= maxSteps; i++) {
          if (i > 1) await window.animationFrame;
          final nextPos = originalScrollTop + (scrollDiff * i / maxSteps);
          scrollContainer.scrollTo(0, nextPos);
        }
      }

      // Wait one animation frame before enabling the content to resize on its own.
      await window.animationFrame;
      content.style.maxHeight = 'none';
    }

    // listen on trigger events
    h.onClick.listen((e) async {
      // Toggle state.
      final isActive = foldable.classes.toggle('-active');
      await update(isActive);
    });
  }
}

Element? _parentWithClass(Element? elem, String className) {
  while (elem != null) {
    if (elem.classes.contains(className)) return elem;
    elem = elem.parent;
  }
  return elem;
}

/// Setup events for forms where a checkbox shows/hides the next block based on its state.
void _setEventForCheckboxToggle() {
  final toggleRoots = document.body!
      .querySelectorAll('.-pub-form-checkbox-toggle-next-sibling');
  for (final elem in toggleRoots) {
    final input = elem.querySelector('input') as InputElement?;
    if (input == null) continue;
    final sibling = elem.nextElementSibling;
    if (sibling == null) continue;
    input.onChange.listen((event) {
      sibling.classes.toggle('-pub-form-block-hidden');
    });
  }
}
