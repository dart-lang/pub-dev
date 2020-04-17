// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

Element _headerRoot;
Element _contentRoot;

void setupTabs() {
  _headerRoot = document.querySelector('ul.detail-tabs-header');
  _contentRoot = document.querySelector('div.detail-tabs-content');
  _setEventsForTabs();

  window.onHashChange.listen((_) {
    _changeTabOnUrlHash();
  });
  _changeTabOnUrlHash();
}

void _setEventsForTabs() {
  if (_headerRoot != null && _contentRoot != null) {
    _headerRoot.onClick.listen((e) {
      Element target = e.target as Element;
      // If a tab link has been clicked, do not change the window location.
      if (target.tagName.toLowerCase() == 'a' &&
          target.attributes.containsKey('href')) {
        return;
      }
      // locate the <li> tag to get the tab name
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
  if (_headerRoot == null) return;
  String hash = window.location.hash ?? '';
  if (hash.startsWith('#')) {
    hash = hash.substring(1);
  }
  // Navigating back to a non-hashed package page will result an empty hash.
  // Displaying the first tab (with content) by default.
  if (hash.isEmpty) {
    final active = _contentRoot.children.firstWhere(
      (e) => e.classes.contains('-active'),
      orElse: () => null,
    );
    if (active == null) {
      changeTab(_contentRoot.children.first.dataset['name']);
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
  final isTabContainer = elem.classes.contains('tab-button') ||
      elem.classes.contains('tab-content');
  if (isTabContainer && elem.dataset['name'] != null) {
    return elem.dataset['name'];
  }
  if (elem.parent == null) {
    return null;
  }
  return getTabName(elem.parent);
}

/// Changes tab to [name], identified by the data-name attribute of the tab
/// header item.
///
/// When no such item exists, the method keeps the current tab active.
void changeTab(String name) {
  final tabOrContentElem = getTabElement(name);
  if (tabOrContentElem == null) return;

  if (tabOrContentElem.classes.contains('tab-button')) {
    _headerRoot.children.forEach((node) => _toggle(node, name));
    _contentRoot.children.forEach((node) => _toggle(node, name));
  } else if (tabOrContentElem.classes.contains('tab-link')) {
    tabOrContentElem.querySelector('a')?.click();
  }
}

Element getTabElement(String name) => _headerRoot
    ?.querySelector('[data-name="${Uri.encodeQueryComponent(name)}"]');

bool hasContentTab(String name) =>
    _contentRoot != null &&
    _contentRoot.children.any((e) => e.dataset['name'] == name);

void _toggle(Element node, String name) {
  if (node.dataset['name'] != name) {
    node.classes.remove('-active');
  } else {
    node.classes.add('-active');
  }
}
