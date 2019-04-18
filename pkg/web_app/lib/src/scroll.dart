// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'tabs.dart';

void setupScroll() {
  _setEventForAnchorScroll();
  window.onHashChange.listen((_) {
    _scrollToHash();
  });
  _scrollToHash();
}

void _scrollToHash() {
  final String hash = window.location.hash ?? '';
  if (hash.isNotEmpty) {
    final id = hash.startsWith('#') ? hash.substring(1) : hash;
    final list =
        document.querySelectorAll('[id="${Uri.encodeQueryComponent(id)}"]');
    if (list.isEmpty) {
      return;
    }
    // if there is an element on the current tab, scroll to it
    final firstVisible =
        list.firstWhere((e) => e.offsetHeight > 0, orElse: () => null);
    if (firstVisible != null) {
      _scrollTo(firstVisible);
      return;
    }
    // switch to the first tab that has the element
    for (Element elem in list) {
      final tabName = getTabName(elem);
      if (tabName != null) {
        changeTab(tabName);
        _scrollTo(elem);
        return;
      }
    }
    // fallback, should not happen
    _scrollTo(list.first);
  }
}

void _setEventForAnchorScroll() {
  document.body.onClick.listen((e) {
    // locate the <a> tag
    Element target = e.target as Element;
    while (target != null &&
        target.tagName.toLowerCase() != 'a' &&
        target.tagName.toLowerCase() != 'body') {
      target = target.parent;
    }
    if (target is AnchorElement &&
        target.getAttribute('href') == target.hash &&
        target.hash != null &&
        target.hash.isNotEmpty) {
      final Element elem = document.querySelector(target.hash);
      if (elem != null) {
        window.history.pushState({}, document.title, target.hash);
        e.preventDefault();
        _scrollTo(elem);
      }
    }
  });
}

Future _scrollTo(Element elem) async {
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
