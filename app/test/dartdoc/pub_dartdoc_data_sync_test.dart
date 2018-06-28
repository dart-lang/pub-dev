// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('pub_dartdoc_data.dart should be the same as pkg/pub_dartdoc', () {
    final appFile = new File('lib/dartdoc/pub_dartdoc_data.dart');
    final pkgFile = new File('../pkg/pub_dartdoc/lib/pub_dartdoc_data.dart');
    expect(appFile.readAsStringSync(), pkgFile.readAsStringSync());
  });

  test('pub_dartdoc_data.g.dart should be the same as pkg/pub_dartdoc', () {
    final appFile = new File('lib/dartdoc/pub_dartdoc_data.g.dart');
    final pkgFile = new File('../pkg/pub_dartdoc/lib/pub_dartdoc_data.g.dart');
    expect(appFile.readAsStringSync(), pkgFile.readAsStringSync());
  });
}
