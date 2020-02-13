// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart';
import 'package:test/test.dart';

import 'package:pub_dev/shared/configuration.dart';

Future scoped(Function() func) {
  return fork(() async {
    return func();
  });
}

void scopedTest(String name, Function() func, {Timeout timeout}) {
  test(name, () {
    return fork(() async {
      // double fork to allow further override
      registerActiveConfiguration(Configuration.test());
      return await fork(() async => func());
    });
  }, timeout: timeout);
}
