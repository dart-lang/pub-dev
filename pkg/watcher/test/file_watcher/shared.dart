// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:scheduled_test/scheduled_test.dart';
import 'package:watcher/src/utils.dart';

import '../utils.dart';

void sharedTests() {
  test("doesn't notify if the file isn't modified", () {
    startWatcher(path: "file.txt");
    // Give the watcher time to fire events if it's going to.
    schedule(() => pumpEventQueue());
    deleteFile("file.txt");
    expectRemoveEvent("file.txt");
  });

  test("notifies when a file is modified", () {
    startWatcher(path: "file.txt");
    writeFile("file.txt", contents: "modified");
    expectModifyEvent("file.txt");
  });

  test("notifies when a file is removed", () {
    startWatcher(path: "file.txt");
    deleteFile("file.txt");
    expectRemoveEvent("file.txt");
  });

  test("notifies when a file is modified multiple times", () {
    startWatcher(path: "file.txt");
    writeFile("file.txt", contents: "modified");
    expectModifyEvent("file.txt");
    writeFile("file.txt", contents: "modified again");
    expectModifyEvent("file.txt");
  });

  test("notifies even if the file contents are unchanged", () {
    startWatcher(path: "file.txt");
    writeFile("file.txt");
    expectModifyEvent("file.txt");
  });

  test("emits a remove event when the watched file is moved away", () {
    startWatcher(path: "file.txt");
    renameFile("file.txt", "new.txt");
    expectRemoveEvent("file.txt");
  });

  test("emits a modify event when another file is moved on top of the watched "
      "file", () {
    writeFile("old.txt");
    startWatcher(path: "file.txt");
    renameFile("old.txt", "file.txt");
    expectModifyEvent("file.txt");
  });

  // Regression test for a race condition.
  test("closes the watcher immediately after deleting the file", () {
    writeFile("old.txt");
    var watcher = createWatcher(path: "file.txt", waitForReady: false);
    var sub = schedule(() => watcher.events.listen(null));

    deleteFile("file.txt");
    schedule(() async {
      // Reproducing the race condition will always be flaky, but this sleep
      // helped it reproduce more consistently on my machine.
      await new Future.delayed(new Duration(milliseconds: 10));
      (await sub).cancel();
    });
  });
}
