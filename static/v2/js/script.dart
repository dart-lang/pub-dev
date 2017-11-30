// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

Element tabRoot;
List<Element> tabContents;

void main() {
  tabRoot = document.querySelector('.js-tabs');
  tabContents = document.querySelectorAll('.js-content');
  _setEventsForTabs();
  _setEventForAnchorScroll();
  _setEventForMobileNav();
  _setEventForHashChange();
}

void _setEventsForTabs() {
  if (tabRoot != null && tabContents.isNotEmpty) {
    tabRoot.onClick.listen((e) {
      // locate the <li> tag
      Element target = e.target;
      while (target != null &&
          target.tagName.toLowerCase() != 'li' &&
          target.tagName.toLowerCase() != 'body') {
        target = target.parent;
      }
      String targetName = target?.dataset['name'];
      if (targetName != null) {
        window.location.hash = '#$targetName';
      }
    });
  }
}

void _setEventForAnchorScroll() {
  document.body.onClick.listen((e) {
    // locate the <a> tag
    Element target = e.target;
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
        e.preventDefault();
        _scrollTo(elem);
      }
    }
  });
}

void _setEventForMobileNav() {
  // hamburger menu on mobile
  final Element hamburger = document.querySelector('.hamburger');
  final Element close = document.querySelector('.close');
  final Element mask = document.querySelector('.mask');
  final Element nav = document.querySelector('.nav-wrap');

  hamburger.onClick.listen((_) {
    nav.classes.add('-show');
    mask.classes.add('-show');
  });
  close.onClick.listen((_) {
    nav.classes.remove('-show');
    mask.classes.remove('-show');
  });
  mask.onClick.listen((_) {
    nav.classes.remove('-show');
    mask.classes.remove('-show');
  });
}

void _changeTabOnUrlHash() {
  // change the tab based on URL hash
  if (tabRoot != null && (window.location.hash ?? '').isNotEmpty) {
    _changeTab(window.location.hash.substring(1));
  }
}

void _changeTab(String name) {
  if (tabRoot.querySelector('[data-name=' + name + ']') != null) {
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

void _setEventForHashChange() {
  window.onHashChange.listen((_) {
    _changeTabOnUrlHash();
  });
  _changeTabOnUrlHash();
  final String hash = window.location.hash;
  if (hash.isNotEmpty) {
    Element elem = document.querySelector(hash);
    if (elem != null) {
      _scrollTo(elem);
    }
  }
}

Future _scrollTo(Element elem) async {
  final int stepCount = 30;
  final int offsetTop = elem.offsetTop - 24;
  final int scrollY = window.scrollY;
  final int diff = offsetTop - scrollY;
  for (int i = 0; i < stepCount; i++) {
    await window.animationFrame;
    window.scrollTo(window.scrollX, scrollY + diff * (i + 1) ~/ stepCount);
  }
}
