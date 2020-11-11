// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void setupHoverable() {
  _setEventForHoverable();
  _setEventForPackageTitleCopyToClipboard();
}

Element _activeHover;

/// Elements with the `hoverable` class provide hover tooltip for both desktop
/// browsers and touchscreen devices:
///   - when clicked, they are added a `hover` class (toggled on repeated clicks)
///   - when any outside part is clicked, the `hover` class is removed
///   - when the mouse enters *another* `hoverable` element, the previously
///     active has its style removed
///
///  Their `:hover` and `.hover` style must match to have the same effect.
void _setEventForHoverable() {
  document.body.onClick.listen(deactivateHover);
  for (Element h in document.querySelectorAll('.hoverable')) {
    registerHoverable(h);
  }
}

/// Deactivates the active hover (hiding the hovering panel).
void deactivateHover(_) {
  if (_activeHover != null) {
    _activeHover.classes.remove('hover');
    _activeHover = null;
  }
}

/// Registers the given Element to follow hoverable events.
void registerHoverable(Element h) {
  h.onClick.listen((e) {
    if (h != _activeHover) {
      deactivateHover(e);
      _activeHover = h;
      _activeHover.classes.add('hover');
      e.stopPropagation();
    }
  });
  h.onMouseEnter.listen((e) {
    if (h != _activeHover) {
      deactivateHover(e);
    }
  });
}

void _setEventForPackageTitleCopyToClipboard() {
  final root = document.querySelector('.pkg-page-title-copy-hoverable');
  root?.querySelectorAll('.pkg-page-title-copy-item')?.forEach((elem) {
    elem.onClick.listen((e) async {
      _copyToClipboard(elem.text.trim());

      // remove hover style on parent
      deactivateHover(null);

      // prevent re-adding hover style on parent
      e.stopPropagation();

      // force unhover in case :hover was the trigger
      root.classes.add('unhover');
      await window.animationFrame;
      // NOTE: keep in sync with _pkg.scss 0.3s animation
      await Future.delayed(Duration(milliseconds: 300));
      await window.animationFrame;
      root.classes.remove('unhover');
      await window.animationFrame;
      root.querySelector('.pkg-page-title-copy-dropdown').style.display = 'none';
      await window.animationFrame;
      root.querySelector('.pkg-page-title-copy-dropdown').style.display = 'block';
    });
  });
}

void _copyToClipboard(String text) {
  final ta = TextAreaElement();
  ta.value = text;
  document.body.append(ta);
  ta.select();
  document.execCommand('copy');
  ta.remove();
}
