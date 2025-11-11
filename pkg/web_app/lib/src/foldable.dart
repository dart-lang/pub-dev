// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:js_interop';
import 'dart:math' show max, min;

import 'package:web/web.dart';
import 'web_util.dart';

void setupFoldable() {
  _setEventForFoldable();
  _setEventForCheckboxToggle();
  _setEventForLicenseDeleteIcons();
}

/// Elements with the `foldable` class provide a folding content:
///   - when the `foldable-button` is clicked, the `-active` class on `foldable` is toggled
///   - when the `foldable` is active, the `foldable-content` element is displayed.
void _setEventForFoldable() {
  final buttons = document
      .querySelectorAll('.foldable-button')
      .toElementList<HTMLElement>();
  for (final h in buttons) {
    final foldable = _parentWithClass(h, 'foldable');
    if (foldable == null) continue;

    final content = foldable.querySelector('.foldable-content');
    final scrollContainer =
        _parentWithClass(h, 'scroll-container') as HTMLElement?;
    if (content == null) continue;

    Future<void> toggle() async {
      final isActive = foldable.classList.toggle('-active');
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
          scrollContainer.scrollTo(0.toJS, originalScrollTop + scrollDiff);
        }
      }
    }

    final foldableIcon = h.querySelector('.foldable-icon');
    if (foldableIcon != null) {
      foldableIcon.setAttribute('tabindex', '0');
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
    if (elem.classList.contains(className)) return elem;
    elem = elem.parentElement;
  }
  return elem;
}

/// Setup events for forms where a checkbox shows/hides the next block based on its state.
void _setEventForCheckboxToggle() {
  final toggleRoots = document.body!
      .querySelectorAll('.-pub-form-checkbox-toggle-next-sibling')
      .toElementList<HTMLElement>();
  for (final elem in toggleRoots) {
    final input = elem.querySelector('input') as HTMLInputElement?;
    if (input == null) continue;
    final sibling = elem.nextElementSibling;
    if (sibling == null) continue;
    input.onChange.listen((event) {
      sibling.classList.toggle('-pub-form-block-hidden');
    });
  }
}

/// Setup a toggle event for the delete operation icons in licenses.
void _setEventForLicenseDeleteIcons() {
  final icons = document.body!
      .querySelectorAll('.license-op-delete-icon')
      .toElementList();
  for (final icon in icons) {
    icon.onClick.listen((event) {
      icon.parentElement!.classList.toggle('license-op-delete-hidden');
    });
  }
}
