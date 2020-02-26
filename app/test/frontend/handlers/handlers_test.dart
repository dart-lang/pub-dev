// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  group('bad request', () {
    testWithServices('/%D0%C2%BD%A8%CE%C4%BC%FE%BC%D0.zip', () async {
      final rs = await issueGet('/%D0%C2%BD%A8%CE%C4%BC%FE%BC%D0.zip');
      expect(rs.statusCode, 400);
    });
  });
}
