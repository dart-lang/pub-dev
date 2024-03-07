// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/utils/flutter_archive.dart';
import 'package:test/test.dart';

void main() {
  test('has beta version', () async {
    final archive = await fetchFlutterArchive();
    expect(archive!.latestStable, isNotNull);
    expect(archive.latestBeta, isNotNull);
    // we usually have a new stable release in every 3-5 weeks
    expect(
      DateTime.now().difference(archive.latestBeta!.releaseDate!).inDays,
      lessThan(45),
    );
    // we usually have a new beta release in every 2-3 weeks
    expect(
      DateTime.now().difference(archive.latestBeta!.releaseDate!).inDays,
      lessThan(30),
    );
  });
}
