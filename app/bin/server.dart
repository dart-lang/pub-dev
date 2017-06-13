// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'service/analyzer.dart' as analyzer;
import 'service/frontend.dart' as frontend;

void main() {
  final String service = Platform.environment['GAE_SERVICE'];
  switch (service) {
    case 'analyzer':
      analyzer.main();
      break;
    case 'default':
      frontend.main();
      break;
    default:
      throw new StateError('Uknown GAE_SERVICE environment: $service');
  }
}
