// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:test/test.dart';

class CommandRunnerWithFooter extends CommandRunner {
  String get usageFooter => "Also, footer!";

  CommandRunnerWithFooter(String executableName, String description)
      : super(executableName, description);
}

class FooCommand extends Command {
  var hasRun = false;

  final name = "foo";
  final description = "Set a value.";
  final takesArguments = false;

  void run() {
    hasRun = true;
  }
}

class ValueCommand extends Command<int> {
  final name = "foo";
  final description = "Return a value.";
  final takesArguments = false;

  int run() => 12;
}

class AsyncValueCommand extends Command<String> {
  final name = "foo";
  final description = "Return a future.";
  final takesArguments = false;

  Future<String> run() async => "hi";
}

class MultilineCommand extends Command {
  var hasRun = false;

  final name = "multiline";
  final description = "Multi\nline.";
  final takesArguments = false;

  void run() {
    hasRun = true;
  }
}

class MultilineSummaryCommand extends MultilineCommand {
  String get summary => description;
}

class HiddenCommand extends Command {
  var hasRun = false;

  final name = "hidden";
  final description = "Set a value.";
  final hidden = true;
  final takesArguments = false;

  void run() {
    hasRun = true;
  }
}

class AliasedCommand extends Command {
  var hasRun = false;

  final name = "aliased";
  final description = "Set a value.";
  final takesArguments = false;
  final aliases = const ["alias", "als"];

  void run() {
    hasRun = true;
  }
}

class AsyncCommand extends Command {
  var hasRun = false;

  final name = "async";
  final description = "Set a value asynchronously.";
  final takesArguments = false;

  Future run() => new Future.value().then((_) => hasRun = true);
}

void throwsIllegalArg(function, {String reason: null}) {
  expect(function, throwsArgumentError, reason: reason);
}

void throwsFormat(ArgParser parser, List<String> args) {
  expect(() => parser.parse(args), throwsFormatException);
}

Matcher throwsUsageException(message, usage) {
  return throwsA(predicate((error) {
    expect(error, new isInstanceOf<UsageException>());
    expect(error.message, message);
    expect(error.usage, usage);
    return true;
  }));
}
