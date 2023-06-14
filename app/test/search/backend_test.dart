// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/search/sdk_mem_index.dart';
import 'package:pub_dev/task/global_lock.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('search backend', () {
    testWithProfile('fetch SDK library description', fn: () async {
      final index = SdkMemIndex.dart();
      final descr = await searchBackend.fetchSdkLibraryDescriptions(
        baseUri: index.baseUri,
        libraryRelativeUrls: {
          'dart:async': 'dart-async/dart-async-library.html',
        },
      );
      expect(descr, {
        'dart:async':
            'Support for asynchronous programming, with classes such as Future and Stream.',
      });
    });

    testWithProfile('updates snapshot storage', fn: () async {
      var documents = await searchBackend.fetchSnapshotDocuments();
      expect(documents, isNull);
      await searchBackend.doCreateAndUpdateSnapshot(
        _FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      documents = await searchBackend.fetchSnapshotDocuments();
      expect(documents, isNotEmpty);
    });
  });
}

class _FakeGlobalLockClaim implements GlobalLockClaim {
  @override
  DateTime expires;

  _FakeGlobalLockClaim(this.expires);

  @override
  Future<bool> refresh() async {
    return true;
  }

  @override
  Future<void> release() async {}

  @override
  bool get valid => expires.isAfter(clock.now());
}
