// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@JS()
library;

import 'dart:js_interop';

import 'package:web/web.dart' as dart_html;

@JS('dataLayer.push')
external void _push(JSAny? data);

void _pushMap(Map<String, dynamic> data) {
  _push(data.jsify());
}

/// Records a GTM [action] with within a [category].
void gtmCustomEvent({
  required String category,
  required String action,
}) {
  _pushMap({
    'event': 'custom-event', // hardcoded, used in GTM Trigger
    'customEventCategory': category,
    'customEventAction': action,
    'customEventLabel': 'path:${dart_html.window.location.pathname}',
    'customEventValue': '1',
  });
}
