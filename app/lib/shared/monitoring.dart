// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';

extension LoggerExt on Logger {
  void pubWarning(String code, String message, [Object error, StackTrace st]) {
    warning('[pub-notice:$code] $message', error, st);
  }

  void pubShout(String code, String message, [Object error, StackTrace st]) {
    shout('[pub-notice:$code] $message', error, st);
  }
}
