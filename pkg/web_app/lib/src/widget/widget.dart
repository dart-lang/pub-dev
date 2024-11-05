// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:js_interop';

import 'package:collection/collection.dart';
import 'package:web/web.dart';

import '../web_util.dart';
import 'completion/widget.dart' deferred as completion;
import 'switch/widget.dart' as switch_;
import 'weekly_sparkline/widget.dart' as weeklySparkline;

/// Function to create an instance of the widget given an element and options.
///
/// [element] which carries `data-widget="$name"`.
/// [options] a map from options to values, where options are specified as
/// `data-$name-$option="$value"`.
///
/// Hence, a widget called `completion` is created on an element by adding
/// `data-widget="completion"`. And option `src` is specified with:
/// `data-completion-src="$value"`.
typedef _WidgetFn = FutureOr<void> Function(
  HTMLElement element,
  Map<String, String> options,
);

/// Function for loading a widget.
typedef _WidgetLoaderFn = FutureOr<_WidgetFn> Function();

/// Map from widget name to widget loader
final _widgets = <String, _WidgetLoaderFn>{
  'completion': () => completion.loadLibrary().then((_) => completion.create),
  'switch': () => switch_.create,
  'weekly-sparkline': () => weeklySparkline.create,
};

Future<_WidgetFn> _noSuchWidget() async =>
    (_, __) => throw AssertionError('no such widget');

void setupWidgets() async {
  final widgetAndElements = document
      // query for all elements with the property `data-widget="..."`
      .querySelectorAll('[data-widget]')
      .toList() // Convert NodeList to List
      // We only care about elements
      .where((node) => node.isA<HTMLElement>())
      .map((node) => node as HTMLElement)
      // group by widget
      .groupListsBy((element) => element.getAttribute('data-widget') ?? '');

  // For each (widget, elements) load widget and create widgets
  await Future.wait(widgetAndElements.entries.map((entry) async {
    // Get widget name and elements which it should be created for
    final MapEntry(key: name, value: elements) = entry;

    // Find the widget and load it
    final widget = await (_widgets[name] ?? _noSuchWidget)();

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
            attr.substring(prefix.length),
            element.getAttribute(attr) ?? '',
          );
        }));

        await widget(element, options);
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
