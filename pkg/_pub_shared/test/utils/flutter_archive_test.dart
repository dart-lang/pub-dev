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
    // we usually have new releases every 3-5 weeks
    expect(
      DateTime.now().difference(archive.latestStable!.releaseDate!).inDays,
      lessThan(45),
    );
    expect(
      DateTime.now().difference(archive.latestBeta!.releaseDate!).inDays,
      lessThan(45),
    );
  });
}
