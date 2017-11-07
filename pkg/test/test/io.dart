// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:package_resolver/package_resolver.dart';
import 'package:path/path.dart' as p;
import 'package:test_descriptor/test_descriptor.dart' as d;
import 'package:test_process/test_process.dart';

import 'package:test/test.dart';

/// The path to the root directory of the `test` package.
final Future<String> packageDir = PackageResolver.current.packagePath('test');

/// The path to the `pub` executable in the current Dart SDK.
final _pubPath = p.absolute(p.join(p.dirname(Platform.resolvedExecutable),
    Platform.isWindows ? 'pub.bat' : 'pub'));

/// The platform-specific message emitted when a nonexistent file is loaded.
final String noSuchFileMessage = Platform.isWindows
    ? "The system cannot find the file specified."
    : "No such file or directory";

/// A regular expression that matches the output of "pub serve".
final _servingRegExp =
    new RegExp(r'^Serving myapp [a-z]+ on http://localhost:(\d+)$');

/// An operating system name that's different than the current operating system.
final otherOS = Platform.isWindows ? "mac-os" : "windows";

/// The port of a pub serve instance run via [runPubServe].
///
/// This is only set after [runPubServe] is called.
int get pubServePort => _pubServePort;
int _pubServePort;

/// Expects that the entire stdout stream of [test] equals [expected].
void expectStdoutEquals(TestProcess test, String expected) =>
    _expectStreamEquals(test.stdoutStream(), expected);

/// Expects that the entire stderr stream of [test] equals [expected].
void expectStderrEquals(TestProcess test, String expected) =>
    _expectStreamEquals(test.stderrStream(), expected);

/// Expects that the entirety of the line stream [stream] equals [expected].
void _expectStreamEquals(Stream<String> stream, String expected) {
  expect((() async {
    var lines = await stream.toList();
    expect(lines.join("\n").trim(), equals(expected.trim()));
  })(), completes);
}

/// Returns a [StreamMatcher] that asserts that the stream emits strings
/// containing each string in [strings] in order.
///
/// This expects each string in [strings] to match a different string in the
/// stream.
StreamMatcher containsInOrder(Iterable<String> strings) =>
    emitsInOrder(strings.map((string) => emitsThrough(contains(string))));

/// Runs the test executable with the package root set properly.
Future<TestProcess> runTest(Iterable<String> args,
    {String reporter,
    int concurrency,
    Map<String, String> environment,
    bool forwardStdio: false}) async {
  concurrency ??= 1;

  var allArgs = [
    p.absolute(p.join(await packageDir, 'bin/test.dart')),
    "--concurrency=$concurrency"
  ];
  if (reporter != null) allArgs.add("--reporter=$reporter");
  allArgs.addAll(args);

  if (environment == null) environment = {};
  environment.putIfAbsent("_DART_TEST_TESTING", () => "true");

  return await runDart(allArgs,
      environment: environment,
      description: "dart bin/test.dart",
      forwardStdio: forwardStdio);
}

/// Runs Dart.
Future<TestProcess> runDart(Iterable<String> args,
    {Map<String, String> environment,
    String description,
    bool forwardStdio: false}) async {
  var allArgs = <String>[]
    ..addAll(Platform.executableArguments.where((arg) =>
        !arg.startsWith("--package-root=") && !arg.startsWith("--packages=")))
    ..add(await PackageResolver.current.processArgument)
    ..addAll(args);

  return await TestProcess.start(
      p.absolute(Platform.resolvedExecutable), allArgs,
      workingDirectory: d.sandbox,
      environment: environment,
      description: description,
      forwardStdio: forwardStdio);
}

/// Runs Pub.
Future<TestProcess> runPub(Iterable<String> args,
    {Map<String, String> environment}) {
  return TestProcess.start(_pubPath, args,
      workingDirectory: d.sandbox,
      environment: environment,
      description: "pub ${args.first}");
}

/// Runs "pub serve".
///
/// This returns assigns [_pubServePort] to a future that will complete to the
/// port of the "pub serve" instance.
Future<TestProcess> runPubServe(
    {Iterable<String> args,
    String workingDirectory,
    Map<String, String> environment}) async {
  var allArgs = ['serve', '--port', '0'];
  if (args != null) allArgs.addAll(args);

  var pub = await runPub(allArgs, environment: environment);

  Match match;
  while (match == null) {
    match = _servingRegExp.firstMatch(await pub.stdout.next);
  }
  _pubServePort = int.parse(match[1]);

  return pub;
}
