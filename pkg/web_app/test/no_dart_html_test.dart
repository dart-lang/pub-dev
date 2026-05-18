// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('no dart:html use in pkg/web_app', () async {
    final dir = Directory('lib');
    await for (final f in dir.list(recursive: true)) {
      if (f is File && f.path.endsWith('.dart')) {
        final content = await f.readAsString();
        expect(content, isNot(contains('dart:html')), reason: f.path);
      }
    }
  });
}
