// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

Element tabRoot;
List<Element> tabContents;

void setupTabs() {
  tabRoot = document.querySelector('.js-tabs');
  tabContents = document.querySelectorAll('.js-content');
  _setEventsForTabs();

  window.onHashChange.listen((_) {
    _changeTabOnUrlHash();
  });
  _changeTabOnUrlHash();
}

void _setEventsForTabs() {
  if (tabRoot != null && tabContents.isNotEmpty) {
    tabRoot.onClick.listen((e) {
      // locate the <li> tag
      Element target = e.target as Element;
      while (target != null &&
          target.tagName.toLowerCase() != 'li' &&
          target.tagName.toLowerCase() != 'body') {
        target = target.parent;
      }
      final String targetName = target?.dataset['name'];
      if (targetName != null) {
        window.location.hash = '#$targetName';
      }
    });
  }
}

/// change the tab based on URL hash
void _changeTabOnUrlHash() {
  if (tabRoot == null) return;
  String hash = window.location.hash ?? '';
  if (hash.startsWith('#')) {
    hash = hash.substring(1);
  }
  // Navigating back to a non-hashed package page will result an empty hash.
  // Displaying the first tab (with content) by default.
  if (hash.isEmpty) {
    final active = tabContents.firstWhere(
      (e) => e.classes.contains('-active'),
      orElse: () => null,
    );
    if (active == null) {
      changeTab(tabContents.first.dataset['name']);
    }
  } else {
    if (hash.startsWith('pub-pkg-tab-')) {
      hash = '-${hash.substring(12)}-tab-';
      window.location.hash = '#$hash';
    }
    changeTab(hash);
  }
}

String getTabName(Element elem) {
  final isTabContainer =
      elem.classes.contains('tab') || elem.classes.contains('content');
  if (isTabContainer && elem.dataset['name'] != null) {
    return elem.dataset['name'];
  }
  if (elem.parent == null) {
    return null;
  }
  return getTabName(elem.parent);
}

void changeTab(String name) {
  final tabOrContentElem =
      tabRoot.querySelector('[data-name="${Uri.encodeQueryComponent(name)}"]');
  if (tabOrContentElem != null) {
    // toggle tab highlights
    tabRoot.children.forEach((node) {
      if (node.dataset['name'] != name) {
        node.classes.remove('-active');
      } else {
        node.classes.add('-active');
      }
    });
    // toggle content
    tabContents.forEach((node) {
      if (node.dataset['name'] != name) {
        node.classes.remove('-active');
      } else {
        node.classes.add('-active');
      }
    });
  }
}
