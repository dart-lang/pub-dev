// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('linux || mac-os')

import 'package:scheduled_test/scheduled_test.dart';
import 'package:watcher/watcher.dart';

import 'shared.dart';
import '../utils.dart';

void main() {
  watcherFactory = (file) => new PollingFileWatcher(file,
      pollingDelay: new Duration(milliseconds: 100));

  setUp(() {
    createSandbox();
    writeFile("file.txt");
  });

  sharedTests();
}
