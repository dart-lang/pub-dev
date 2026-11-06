// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Tags(['presubmit-only'])
library;

import 'package:_pub_shared/worker/docker_utils.dart';
import 'package:test/test.dart';

void main() {
  test('building and running Dockerfile.app', () async {
    await buildAppDockerImage();

    // The image is only usable when the server can load the native libraries
    // of `package:sigstore` and `package:boring` from the snapshot it runs,
    // see `tool/build-server-snapshot.sh`.
    final output = await runAppDockerImage(['self-check']);
    expect(output, contains('self-check: OK'));
  }, timeout: Timeout(Duration(minutes: 20)));
}
