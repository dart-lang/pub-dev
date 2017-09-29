// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/analyzer_client.dart';

Future scoped(func()) {
  return fork(() async {
    return func();
  });
}

void scopedTest(String name, func(), {Timeout timeout}) {
  test(name, () {
    return fork(() async {
      return func();
    });
  }, timeout: timeout);
}

class MockAnalysisView implements AnalysisView {
  @override
  bool hasAnalysisData = true;

  @override
  AnalysisStatus analysisStatus;

  @override
  List<String> getTransitiveDependencies() => throw 'Not implemented';

  @override
  double health;

  @override
  String licenseText;

  @override
  DateTime timestamp;

  @override
  List<String> platforms;

  MockAnalysisView({this.platforms});
}
