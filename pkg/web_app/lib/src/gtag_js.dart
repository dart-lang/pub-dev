// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@JS('window')
library gtag_js;

import 'package:js/js.dart';
import 'package:meta/meta.dart';

@JS('gtag')
external dynamic _gtag(String type, String action, Map<String, dynamic> data);

void gtagEvent(
  String action, {
  @required String category,
  @required String label,
}) =>
    _gtag('event', action, {
      'event_category': category,
      'event_label': label,
    });
