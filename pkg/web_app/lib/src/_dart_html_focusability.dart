// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO: migrate to package:web
// ignore: deprecated_member_use
import 'dart:html';

/// These selectors provide the elements that are focusable through tab or
/// keyboard navigation.
const _focusableSelectors = <String>[
  'a',
  'audio',
  'button',
  'canvas',
  'details',
  'iframe',
  'input',
  'select',
  'summary',
  'textarea',
  'video',
  '[accesskey]',
  '[contenteditable]',
  '[tabindex]',
];

/// Disables all focusable elements, except for the elements inside
/// [allowedComponents]. Returns a [Function] that will restore the
/// original focusability state of the disabled elements.
void Function() disableAllFocusability({
  required List<Element> allowedComponents,
}) {
  final focusableElements = document.body!.querySelectorAll(
    _focusableSelectors.join(', '),
  );
  final restoreFocusabilityFns = <void Function()>[];
  for (final e in focusableElements) {
    if (allowedComponents.any((content) => _isInsideContent(e, content))) {
      continue;
    }
    restoreFocusabilityFns.add(_disableFocusability(e));
  }
  return () {
    for (final fn in restoreFocusabilityFns) {
      fn();
    }
  };
}

/// Update [e] to disable focusability and return a [Function] that can be
/// called to revert its original state.
void Function() _disableFocusability(Element e) {
  final isLink = e.tagName.toLowerCase() == 'a';
  final hasTabindex = e.hasAttribute('tabindex');
  final attributesToSet = <String, String>{
    if (isLink || hasTabindex) 'tabindex': '-1',
    if (!isLink) 'disabled': 'disabled',
    'aria-hidden': 'true',
  };
  final attributesToRestore = attributesToSet.map(
    (key, _) => MapEntry(key, e.getAttribute(key)),
  );
  for (final a in attributesToSet.entries) {
    e.setAttribute(a.key, a.value);
  }
  return () {
    for (final a in attributesToRestore.entries) {
      final value = a.value;
      if (value == null) {
        e.removeAttribute(a.key);
      } else {
        e.setAttribute(a.key, value);
      }
    }
  };
}

bool _isInsideContent(Element e, Element content) {
  // check if [e] is under [content].
  Element? p = e;
  while (p != null) {
    if (p == content) {
      return true;
    }
    p = p.parent;
  }
  return false;
}
