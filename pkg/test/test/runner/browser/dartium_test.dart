// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")
@Tags(const ["dartium"])

import 'package:test_descriptor/test_descriptor.dart' as d;

import 'package:test/src/runner/browser/dartium.dart';
import 'package:test/src/runner/executable_settings.dart';
import 'package:test/test.dart';

import '../../io.dart';
import '../../utils.dart';
import 'code_server.dart';

void main() {
  test("starts Dartium with the given URL", () async {
    var server = await CodeServer.start();

    server.handleDart('''
var webSocket = new WebSocket(
    window.location.href.replaceFirst("http://", "ws://"));
await webSocket.onOpen.first;
webSocket.send("loaded!");
''');
    var webSocket = server.handleWebSocket();

    var dartium = new Dartium(server.url);
    addTearDown(() => dartium.close());

    expect(await (await webSocket).stream.first, equals("loaded!"));
  });

  test("a process can be killed synchronously after it's started", () async {
    var server = await CodeServer.start();

    var dartium = new Dartium(server.url);
    await dartium.close();
  });

  test("reports an error in onExit", () {
    var dartium = new Dartium("http://dart-lang.org",
        settings: new ExecutableSettings(
            linuxExecutable: "_does_not_exist",
            macOSExecutable: "_does_not_exist",
            windowsExecutable: "_does_not_exist"));
    expect(
        dartium.onExit,
        throwsA(isApplicationException(
            startsWith("Failed to run Dartium: $noSuchFileMessage"))));
  });

  test("can run successful tests", () async {
    await d.file("test.dart", """
import 'package:test/test.dart';

void main() {
  test("success", () {});
}
""").create();

    var test = await runTest(["-p", "dartium", "test.dart"]);
    expect(test.stdoutStream(), neverEmits(contains("Compiling")));
    expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
    await test.shouldExit(0);
  });

  test("can run failing tests", () async {
    await d.file("test.dart", """
import 'package:test/test.dart';

void main() {
  test("failure", () => throw new TestFailure("oh no"));
}
""").create();

    var test = await runTest(["-p", "dartium", "test.dart"]);
    expect(test.stdout, emitsThrough(contains("-1: Some tests failed.")));
    await test.shouldExit(1);
  });
}
