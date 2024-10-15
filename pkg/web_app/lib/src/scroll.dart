// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void setupScroll() {
  _setEventForAnchorScroll();
  window.onHashChange.listen((_) {
    _scrollToHash();
  });
  _scrollToHash();
}

void _scrollToHash() {
  final hash = window.location.hash;
  if (hash.isNotEmpty) {
    final id = hash.startsWith('#') ? hash.substring(1) : hash;
    final list =
        document.querySelectorAll('[id="${Uri.encodeQueryComponent(id)}"]');
    if (list.isEmpty) {
      return;
    }
    // if there is an element on the current tab, scroll to it
    for (final e in list) {
      if (e.offsetHeight > 0) {
        _scrollTo(e);
        return;
      }
    }
    // fallback, should not happen
    _scrollTo(list.first);
  }
}

void _setEventForAnchorScroll() {
  document.body!.onClick.listen((e) {
    // locate the <a> tag
    var target = e.target as Element?;
    while (target != null &&
        target.tagName.toLowerCase() != 'a' &&
        target.tagName.toLowerCase() != 'body') {
      target = target.parent;
    }
    if (target is AnchorElement &&
        target.getAttribute('href') == target.hash &&
        (target.hash?.isNotEmpty ?? false)) {
      final elem = document.querySelector(target.hash!);
      if (elem != null) {
        window.history
            .pushState(<String, String>{}, document.title, target.hash);
        e.preventDefault();
        _scrollTo(elem);
      }
    }
  });
}

Future<void> _scrollTo(Element elem) async {
  // Chrome could provide inconsistent position data just after the page has
  // been loaded. The first animation frame makes sure that the rendering is
  // stabilized and the position data is correct.
  await window.animationFrame;
  final int stepCount = 30;
  for (int i = 0; i < stepCount; i++) {
    await window.animationFrame;
    final int offsetTop = elem.offsetTop - 12;
    final int scrollY = window.scrollY;
    final int diff = offsetTop - scrollY;
    // Stop early if the browser already jumped to it.
    if (i == 0 && diff <= 12) {
      break;
    }
    window.scrollTo(window.scrollX, scrollY + diff * (i + 1) ~/ stepCount);
  }
}
