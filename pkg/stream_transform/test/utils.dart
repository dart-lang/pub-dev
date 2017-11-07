// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// Cycle the event loop to ensure timers are started, then wait for a delay
/// longer than [milliseconds] to allow for the timer to fire.
Future waitForTimer(int milliseconds) =>
    new Future(() {/* ensure Timer is started*/}).then((_) =>
        new Future.delayed(new Duration(milliseconds: milliseconds + 1)));
