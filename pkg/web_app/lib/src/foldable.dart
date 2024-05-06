// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
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

    Future<void> toggle() async {
      final isActive = foldable.classes.toggle('-active');
      if (!isActive) {
        return;
      }

      if (scrollContainer != null) {
        // Wait one animation frame before measurements.
        await window.animationFrame;

        final boundingRect = content.getBoundingClientRect();
        final scrollContainerHeight = scrollContainer.clientHeight;
        final buttonHeight = h.offsetHeight;

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
        final scrollDiff = max(0, min(screenLimit, outsideViewDiff));

        /// Do not scroll if the difference is small.
        if (scrollDiff > 8) {
          final originalScrollTop = scrollContainer.scrollTop;
          scrollContainer.scrollTo(0, originalScrollTop + scrollDiff);
        }
      }
    }

    final foldableIcon = h.querySelector('.foldable-icon');
    if (foldableIcon != null) {
      foldableIcon.attributes['tabindex'] = '0';
    }

    // listen on trigger events
    h.onClick.listen((e) async {
      e.preventDefault();
      await toggle();
    });
    h.onKeyDown.where((e) => e.key == 'Enter').listen((e) async {
      e.preventDefault();
      await toggle();
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
