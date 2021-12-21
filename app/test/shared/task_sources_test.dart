// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/shared/task_sources.dart';
import 'package:test/test.dart';

import 'test_services.dart';

void main() {
  testWithProfile(
    'scan every model once',
    fn: () async {
      for (final model in TaskSourceModel.values) {
        final source = DatastoreHeadTaskSource(dbService, model);
        final items = await source.pollOnce().toList();
        expect(items, isNotEmpty, reason: '$model must have entries');
      }
    },
    processJobsWithFakeRunners: true,
  );
}
