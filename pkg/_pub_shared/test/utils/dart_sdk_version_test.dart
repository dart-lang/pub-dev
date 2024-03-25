// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/utils/sdk_version_cache.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  test('fetch version is valid', () async {
    final v = await getCachedDartSdkVersion(lastKnownStable: '3.0.0');
    expect(v, isNotNull);
    expect(v.version, isNotEmpty);
    expect(v.published, isNotNull);
    expect(v.semanticVersion.isEmpty, isFalse);
    expect(v.semanticVersion.isAny, isFalse);
    expect(v.semanticVersion.isPreRelease, isFalse);
    expect(v.semanticVersion.isFirstPreRelease, isFalse);
    // additional sanity check: 2.10.4 was published on 2020-11-11
    expect(v.semanticVersion.compareTo(Version(2, 10, 3)), greaterThan(0));
    expect(v.published.isAfter(DateTime(2020, 11, 10)), isTrue);
  });
}
