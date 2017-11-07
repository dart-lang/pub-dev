// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:test/test.dart';

import 'utils.dart';

const _DEFAULT_USAGE = """
Usage: test <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  help   Display help information for test.

Run "test help <command>" for more information about a command.""";

void main() {
  var runner;
  setUp(() {
    runner = new CommandRunner("test", "A test command runner.");
  });

  test(".invocation has a sane default", () {
    expect(runner.invocation, equals("test <command> [arguments]"));
  });

  group(".usage", () {
    test("returns the usage string", () {
      expect(runner.usage, equals("""
A test command runner.

$_DEFAULT_USAGE"""));
    });

    test("contains custom commands", () {
      runner.addCommand(new FooCommand());

      expect(runner.usage, equals("""
A test command runner.

Usage: test <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  foo    Set a value.
  help   Display help information for test.

Run "test help <command>" for more information about a command."""));
    });

    test("truncates newlines in command descriptions by default", () {
      runner.addCommand(new MultilineCommand());

      expect(runner.usage, equals("""
A test command runner.

Usage: test <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  help        Display help information for test.
  multiline   Multi

Run "test help <command>" for more information about a command."""));
    });

    test("supports newlines in command summaries", () {
      runner.addCommand(new MultilineSummaryCommand());

      expect(runner.usage, equals("""
A test command runner.

Usage: test <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  help        Display help information for test.
  multiline   Multi
              line.

Run "test help <command>" for more information about a command."""));
    });

    test("contains custom options", () {
      runner.argParser.addFlag("foo", help: "Do something.");

      expect(runner.usage, equals("""
A test command runner.

Usage: test <command> [arguments]

Global options:
-h, --help        Print this usage information.
    --[no-]foo    Do something.

Available commands:
  help   Display help information for test.

Run "test help <command>" for more information about a command."""));
    });

    test("doesn't print hidden commands", () {
      runner.addCommand(new HiddenCommand());

      expect(runner.usage, equals("""
A test command runner.

$_DEFAULT_USAGE"""));
    });

    test("doesn't print aliases", () {
      runner.addCommand(new AliasedCommand());

      expect(runner.usage, equals("""
A test command runner.

Usage: test <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  aliased   Set a value.
  help      Display help information for test.

Run "test help <command>" for more information about a command."""));
    });
  });

  test("usageException splits up the message and usage", () {
    expect(() => runner.usageException("message"),
        throwsUsageException("message", _DEFAULT_USAGE));
  });

  group("run()", () {
    test("runs a command", () {
      var command = new FooCommand();
      runner.addCommand(command);

      expect(runner.run(["foo"]).then((_) {
        expect(command.hasRun, isTrue);
      }), completes);
    });

    test("runs an asynchronous command", () {
      var command = new AsyncCommand();
      runner.addCommand(command);

      expect(runner.run(["async"]).then((_) {
        expect(command.hasRun, isTrue);
      }), completes);
    });

    test("runs a command with a return value", () {
      var runner = new CommandRunner<int>("test", "");
      var command = new ValueCommand();
      runner.addCommand(command);

      expect(runner.run(["foo"]), completion(equals(12)));
    });

    test("runs a command with an asynchronous return value", () {
      var runner = new CommandRunner<String>("test", "");
      var command = new AsyncValueCommand();
      runner.addCommand(command);

      expect(runner.run(["foo"]), completion(equals("hi")));
    });

    test("runs a hidden comand", () {
      var command = new HiddenCommand();
      runner.addCommand(command);

      expect(runner.run(["hidden"]).then((_) {
        expect(command.hasRun, isTrue);
      }), completes);
    });

    test("runs an aliased comand", () {
      var command = new AliasedCommand();
      runner.addCommand(command);

      expect(runner.run(["als"]).then((_) {
        expect(command.hasRun, isTrue);
      }), completes);
    });

    test("runs a subcommand", () {
      var command = new AsyncCommand();
      runner.addCommand(new FooCommand()..addSubcommand(command));

      expect(runner.run(["foo", "async"]).then((_) {
        expect(command.hasRun, isTrue);
      }), completes);
    });

    group("with --help", () {
      test("with no command prints the usage", () {
        expect(() => runner.run(["--help"]), prints("""
A test command runner.

$_DEFAULT_USAGE
"""));
      });

      test("with a preceding command prints the usage for that command", () {
        var command = new FooCommand();
        runner.addCommand(command);

        expect(() => runner.run(["foo", "--help"]), prints("""
Set a value.

Usage: test foo [arguments]
-h, --help    Print this usage information.

Run "test help" to see global options.
"""));
      });

      test("with a following command prints the usage for that command", () {
        var command = new FooCommand();
        runner.addCommand(command);

        expect(() => runner.run(["--help", "foo"]), prints("""
Set a value.

Usage: test foo [arguments]
-h, --help    Print this usage information.

Run "test help" to see global options.
"""));
      });
    });

    group("with help command", () {
      test("with no command prints the usage", () {
        expect(() => runner.run(["help"]), prints("""
A test command runner.

$_DEFAULT_USAGE
"""));
      });

      test("with a command prints the usage for that command", () {
        var command = new FooCommand();
        runner.addCommand(command);

        expect(() => runner.run(["help", "foo"]), prints("""
Set a value.

Usage: test foo [arguments]
-h, --help    Print this usage information.

Run "test help" to see global options.
"""));
      });

      test("prints its own usage", () {
        expect(() => runner.run(["help", "help"]), prints("""
Display help information for test.

Usage: test help [command]
-h, --help    Print this usage information.

Run "test help" to see global options.
"""));
      });
    });

    group("with an invalid argument", () {
      test("at the root throws the root usage", () {
        expect(runner.run(["--asdf"]), throwsUsageException(
            'Could not find an option named "asdf".',
            '$_DEFAULT_USAGE'));
      });

      test("for a command throws the command usage", () {
        var command = new FooCommand();
        runner.addCommand(command);

        expect(runner.run(["foo", "--asdf"]), throwsUsageException(
            'Could not find an option named "asdf".',
            """
Usage: test foo [arguments]
-h, --help    Print this usage information.

Run "test help" to see global options."""));
      });
    });
  });

  group("with a footer", () {
    setUp(() {
      runner = new CommandRunnerWithFooter("test", "A test command runner.");
    });

    test("includes the footer in the usage string", () {
      expect(runner.usage, equals("""
A test command runner.

$_DEFAULT_USAGE
Also, footer!"""));
    });

    test("includes the footer in usage errors", () {
      expect(runner.run(["--bad"]), throwsUsageException(
          'Could not find an option named "bad".',
          "$_DEFAULT_USAGE\nAlso, footer!"));
    });
  });

  group("throws a useful error when", () {
    test("arg parsing fails", () {
      expect(runner.run(["--bad"]), throwsUsageException(
          'Could not find an option named "bad".', _DEFAULT_USAGE));
    });

    test("a top-level command doesn't exist", () {
      expect(runner.run(["bad"]), throwsUsageException(
          'Could not find a command named "bad".', _DEFAULT_USAGE));
    });

    test("a subcommand doesn't exist", () {
      runner.addCommand(new FooCommand()..addSubcommand(new AsyncCommand()));

      expect(runner.run(["foo bad"]), throwsUsageException(
          'Could not find a command named "foo bad".', """
Usage: test <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  foo    Set a value.
  help   Display help information for test.

Run "test help <command>" for more information about a command."""));
    });

    test("a subcommand wasn't passed", () {
      runner.addCommand(new FooCommand()..addSubcommand(new AsyncCommand()));

      expect(runner.run(["foo"]), throwsUsageException(
          'Missing subcommand for "test foo".', """
Usage: test foo <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  async   Set a value asynchronously.

Run "test help" to see global options."""));
    });

    test("a command that doesn't take arguments was given them", () {
      runner.addCommand(new FooCommand());

      expect(runner.run(["foo", "bar"]), throwsUsageException(
          'Command "foo" does not take any arguments.', """
Usage: test foo [arguments]
-h, --help    Print this usage information.

Run "test help" to see global options."""));
    });
  });
}
