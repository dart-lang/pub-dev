// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  final exceptions = {
    // the only valid use
    'lib/shared/datastore.dart',
  };

  test('Only lib/shared/datastore.dart imports gcloud/db.dart', () {
    final foundExceptions = <String>{};
    final gcloudDatastoreFiles = <String>[];
    final gcloudDbFiles = <String>[];
    for (final dir in ['bin', 'lib']) {
      final files = Directory(dir)
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) => !f.path.endsWith('.g.dart'))
          .toList();

      for (final file in files) {
        if (exceptions.contains(file.path)) {
          foundExceptions.add(file.path);
          continue;
        }
        final content = file.readAsStringSync();
        if (content.contains('package:gcloud/datastore.dart')) {
          gcloudDatastoreFiles.add(file.path);
        }
        if (content.contains('package:gcloud/db.dart')) {
          gcloudDbFiles.add(file.path);
        }
      }
    }

    expect(gcloudDatastoreFiles, isEmpty);
    expect(gcloudDbFiles, isEmpty);
    expect(foundExceptions, exceptions);
  });
}
