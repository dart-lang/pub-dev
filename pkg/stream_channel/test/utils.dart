// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// Returns a [Future] that completes after pumping the event queue [times]
/// times.
///
/// By default, this should pump the event queue enough times to allow any code
/// to run, as long as it's not waiting on some external event.
Future pumpEventQueue([int times = 20]) {
  if (times == 0) return new Future.value();
  // Use [new Future] future to allow microtask events to finish. The [new
  // Future.value] constructor uses scheduleMicrotask itself and would therefore
  // not wait for microtask callbacks that are scheduled after invoking this
  // method.
  return new Future(() => pumpEventQueue(times - 1));
}
