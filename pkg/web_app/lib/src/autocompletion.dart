// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

final _widgets = {
  'autocompletion': _createAutocompletionWidget,
};

void setupWidgets() {
  for (final element in document.querySelectorAll('[data-widget]')) {
    final widgetName = element.dataset['widget'] ?? '';
    final widget = _widgets[widgetName];
    try {
      if (widget == null) {
        throw ArgumentError('Unknown widget in data-widget="$widgetName"');
      }
      widget(element);
    } catch (e, st) {
      window.console.error('Failed to initialize data-widget="$widgetName"');
      window.console.error('Triggered by element:');
      window.console.error(element);
      window.console.error(e);
      window.console.error(st);
    }
  }
}

void _createAutocompletionWidget(Element element) {
  if (element is! InputElement) {
    throw UnsupportedError('Must be <input> element');
  }
  if (element.type != 'text') {
    throw UnsupportedError('Must have type="text"');
  }
  final src = element.dataset['autocompletion-src'] ?? '';
  if (src.isEmpty) {
    throw UnsupportedError('Must have autocompletion-src="<url>"');
  }
  final srcUri = Uri.parse(src);

  // Setup attributes
  element.autocomplete = 'false';
  element.attributes['autocorrect'] = 'off'; // safari only

  scheduleMicrotask(() async {
    // Don't do anymore setup before
    await element.onFocus.first;
  });
}
