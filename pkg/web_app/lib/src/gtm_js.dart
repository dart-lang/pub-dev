// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@JS()
library gtm_js;

import 'dart:html' as dart_html;

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('dataLayer.push')
external void _push(data);

void _pushMap(Map<String, dynamic> data) {
  _push(jsify(data));
}

/// Records a GTM [action] with the default [event] name and [category].
void gtmCustomEventClick({
  String event = 'custom-event',
  String category = 'click',
  required String action,
}) {
  _pushMap({
    'event': event,
    'customEventCategory': category,
    'customEventAction': action,
    'customEventLabel': 'path:${dart_html.window.location.pathname}',
    'customEventValue': '1',
  });
}
