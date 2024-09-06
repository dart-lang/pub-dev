// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:js_interop';

import 'package:collection/collection.dart';
import 'package:web/web.dart';

import '../web_util.dart';
import 'completion/widget.dart' deferred as completion;

/// Widget entry
typedef _WidgetEntry = ({
  /// Name of the widget referenced in `data-widget="<name>"`.
  String name,

  /// Function to create an instance of the widget given an element and options.
  ///
  /// [element] which carries `data-widget="$name"`.
  /// [options] a map from options to values, where options are specified as
  /// `data-$name-$option="$value"`.
  ///
  /// Hence, a widget called `completion` is created on an element by adding
  /// `data-widget="completion"`. And option `src` is specified with:
  /// `data-completion-src="$value"`.
  FutureOr<void> Function(Element element, Map<String, String> options) create,

  /// Load widget library, if deferred (otherwise this can be `null`).
  Future<void> Function()? loadLibrary,
});

// List of registered widgets
final _widgets = <_WidgetEntry>[
  (
    name: 'completion',
    create: completion.create,
    loadLibrary: completion.loadLibrary,
  ),
];

Future<void> setupWidgets() async {
  await Future.wait(document
      // query for all elements with the property `data-widget="..."`
      .querySelectorAll('[data-widget]')
      .toList() // Convert NodeList to List
      // We only care about elements
      .where((node) => node.isA<HTMLElement>())
      .map((node) => node as HTMLElement)
      // group by widget
      .groupListsBy((element) => element.getAttribute('data-widget') ?? '')
      .entries
      // For each (widget, elements) load widget and create widgets
      .map((entry) async {
    // Get widget name and elements which it should be created for
    final MapEntry(key: name, value: elements) = entry;

    // Find the widget create function and loadLibrary function
    final (name: _, :create, :loadLibrary) = _widgets.firstWhere(
      (widget) => widget.name == name,
      orElse: () => (
        name: '',
        create: (_, __) => throw AssertionError('no such widget'),
        loadLibrary: null,
      ),
    );

    // Load library if this a deferred widget
    if (loadLibrary != null) {
      await loadLibrary();
    }

    // Create widget for each element
    await Future.wait(elements.map((element) async {
      try {
        final prefix = 'data-$name-';
        final options = Map.fromEntries(element
            .getAttributeNames()
            .iterable
            .where((attr) => attr.startsWith(prefix))
            .map((attr) {
          return MapEntry(
            attr.substring(0, prefix.length),
            element.getAttribute(attr) ?? '',
          );
        }));

        await create(element, options);
      } catch (e, st) {
        console.error('Failed to initialize data-widget="$name"'.toJS);
        console.error('Triggered by element:'.toJS);
        console.error(element);
        console.error(e.toString().toJS);
        console.error(st.toString().toJS);
      }
    }));
  }));
}
