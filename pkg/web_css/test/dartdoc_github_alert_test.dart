// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('The style from dartdoc are copied over.', () {
    final included = File('../../third_party/css/dartdoc-github-alert.css')
        .readAsStringSync();
    final dartdocStyles = File('../../third_party/dartdoc/resources/styles.css')
        .readAsStringSync();
    expect(dartdocStyles, contains(included));
  });
}
