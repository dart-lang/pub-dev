// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';

import 'package:web/web.dart';
import 'package:web_app/src/completion.dart';

import 'web_util.dart';

final _widgets = <String, void Function(Element)>{
  'completion': CompletionWidget.create,
};

void setupWidgets() {
  for (final node in document.querySelectorAll('[data-widget]').toList()) {
    if (!node.isA<HTMLElement>()) continue;
    final element = node as HTMLElement;
    final widgetName = element.getAttribute('data-widget') ?? '';
    final widget = _widgets[widgetName];
    try {
      if (widget == null) {
        throw ArgumentError('Unknown widget in data-widget="$widgetName"');
      }
      widget(element);
    } catch (e, st) {
      console.error('Failed to initialize data-widget="$widgetName"'.toJS);
      console.error('Triggered by element:'.toJS);
      console.error(element);
      console.error(e.toString().toJS);
      console.error(st.toString().toJS);
    }
  }
}
