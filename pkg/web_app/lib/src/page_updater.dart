// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:http/http.dart' deferred as http show get;

typedef PopStateFn = Function();

PopStateFn? _popStateFn;

/// Initialize the search history at the beginning of the app lifecycle
/// with a callback function that should be run on state changes.
void setupPageUpdater(PopStateFn popStateFn) {
  if (_popStateFn != null) {
    throw StateError('popState callback already initialized.');
  }
  _popStateFn = popStateFn;

  // initialize history with the current state
  window.history.replaceState(
    {'html': document.documentElement?.outerHtml},
    document.title,
    window.location.href,
  );

  // handle back button updates
  window.onPopState.listen((event) {
    final state = event.state;
    if (state is Map && state['html'] is String) {
      _update(
        state['html'] as String,
        pushState: false,
        url: null,
      );
    }
  });
}

/// Parse input [html] and replace the current `<body>` element with its `<body>`.
Document _update(
  String html, {
  required bool pushState,
  required String? url,
}) {
  final doc = DomParser().parseFromString(html, 'text/html');
  document.querySelector('body')!.replaceWith(doc.querySelector('body')!);
  _popStateFn!();
  if (pushState) {
    final title = doc.querySelector('title')?.text;
    window.history.pushState({'html': html}, title ?? '', url);
  }
  return doc;
}

/// Request new HTML content and update current page.
Future<void> updateBodyWithHttpGet({
  required Uri requestUri,
  String? navigationUrl,
  Duration timeout = const Duration(seconds: 4),
  bool Function()? preupdateCheck,
}) async {
  try {
    await http.loadLibrary();
    final page = await http.get(requestUri).timeout(timeout);
    if (page.statusCode == 200) {
      if (preupdateCheck == null || preupdateCheck()) {
        _update(
          page.body,
          pushState: true,
          url: navigationUrl ?? requestUri.toString(),
        );
      }
      return;
    }
  } catch (e, st) {
    window.console.error(['Page replace failed.', e, st]);
  }
  // fallback: reload the new URL
  window.location.href = navigationUrl ?? requestUri.toString();
}
