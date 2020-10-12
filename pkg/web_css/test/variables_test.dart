// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('all variables are used', () async {
    final variables = (await File('lib/src/_variables.scss').readAsLines())
        .where((l) => l.startsWith(r'$') && l.contains(':'))
        .map((l) => l.substring(1).split(':').first.trim())
        .where((v) => v.isNotEmpty)
        .toSet();
    expect(variables, isNotEmpty);

    final files = await Directory('lib')
        .list(recursive: true)
        .where((f) => f is File && f.path.endsWith('.scss'))
        .cast<File>()
        .toList();

    for (final file in files) {
      if (variables.isEmpty) break;
      if (file.path.contains('_variables.scss')) continue;
      final content = await file.readAsString();
      final matched = variables.where((v) => content.contains('\$$v')).toList();
      variables.removeAll(matched);
    }

    expect(variables, isEmpty);
  });
}
