// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

import 'package:dart_style/src/dart_formatter.dart';
import 'package:dart_style/src/exceptions.dart';
import 'package:dart_style/src/formatter_options.dart';
import 'package:dart_style/src/io.dart';
import 'package:dart_style/src/source_code.dart';

// Note: The following line of code is modified by tool/grind.dart.
const version = "1.0.8";

void main(List<String> args) {
  var parser = new ArgParser(allowTrailingOptions: true);

  parser.addFlag("help",
      abbr: "h", negatable: false, help: "Shows usage information.");
  parser.addFlag("version",
      negatable: false, help: "Shows version information.");
  parser.addOption("line-length",
      abbr: "l", help: "Wrap lines longer than this.", defaultsTo: "80");
  parser.addOption("indent",
      abbr: "i", help: "Spaces of leading indentation.", defaultsTo: "0");
  parser.addOption("preserve",
      help: 'Selection to preserve, formatted as "start:length".');
  parser.addFlag("dry-run",
      abbr: "n",
      negatable: false,
      help: "Show which files would be modified but make no changes.");
  parser.addFlag("set-exit-if-changed",
      negatable: false,
      help: "Return exit code 1 if there are any formatting changes.");
  parser.addFlag("overwrite",
      abbr: "w",
      negatable: false,
      help: "Overwrite input files with formatted output.");
  parser.addFlag("machine",
      abbr: "m",
      negatable: false,
      help: "Produce machine-readable JSON output.");
  parser.addFlag("profile",
      negatable: false, help: "Display profile times after running.");
  parser.addFlag("follow-links",
      negatable: false,
      help: "Follow links to files and directories.\n"
          "If unset, links will be ignored.");
  parser.addFlag("transform",
      abbr: "t",
      negatable: false,
      help: "Unused flag for compability with the old formatter.");

  ArgResults argResults;
  try {
    argResults = parser.parse(args);
  } on FormatException catch (err) {
    usageError(parser, err.message);
  }

  if (argResults["help"]) {
    printUsage(parser);
    return;
  }

  if (argResults["version"]) {
    print(version);
    return;
  }

  // Can only preserve a selection when parsing from stdin.
  List<int> selection;

  if (argResults["preserve"] != null && argResults.rest.isNotEmpty) {
    usageError(parser, "Can only use --preserve when reading from stdin.");
  }

  try {
    selection = parseSelection(argResults["preserve"]);
  } on FormatException catch (_) {
    usageError(
        parser,
        '--preserve must be a colon-separated pair of integers, was '
        '"${argResults['preserve']}".');
  }

  if (argResults["dry-run"] && argResults["overwrite"]) {
    usageError(
        parser, "Cannot use --dry-run and --overwrite at the same time.");
  }

  checkForReporterCollision(String chosen, String other) {
    if (!argResults[other]) return;

    usageError(parser, "Cannot use --$chosen and --$other at the same time.");
  }

  var reporter = OutputReporter.print;
  if (argResults["dry-run"]) {
    checkForReporterCollision("dry-run", "overwrite");
    checkForReporterCollision("dry-run", "machine");

    reporter = OutputReporter.dryRun;
  } else if (argResults["overwrite"]) {
    checkForReporterCollision("overwrite", "machine");

    if (argResults.rest.isEmpty) {
      usageError(parser,
          "Cannot use --overwrite without providing any paths to format.");
    }

    reporter = OutputReporter.overwrite;
  } else if (argResults["machine"]) {
    reporter = OutputReporter.printJson;
  }

  if (argResults["profile"]) {
    reporter = new ProfileReporter(reporter);
  }

  if (argResults["set-exit-if-changed"]) {
    reporter = new SetExitReporter(reporter);
  }

  var pageWidth;
  try {
    pageWidth = int.parse(argResults["line-length"]);
  } on FormatException catch (_) {
    usageError(
        parser,
        '--line-length must be an integer, was '
        '"${argResults['line-length']}".');
  }

  var indent;

  try {
    indent = int.parse(argResults["indent"]);
    if (indent < 0 || indent.toInt() != indent) throw new FormatException();
  } on FormatException catch (_) {
    usageError(
        parser,
        '--indent must be a non-negative integer, was '
        '"${argResults['indent']}".');
  }

  var followLinks = argResults["follow-links"];

  var options = new FormatterOptions(reporter,
      indent: indent, pageWidth: pageWidth, followLinks: followLinks);

  if (argResults.rest.isEmpty) {
    formatStdin(options, selection);
  } else {
    formatPaths(options, argResults.rest);
  }

  if (argResults["profile"]) {
    (reporter as ProfileReporter).showProfile();
  }
}

List<int> parseSelection(String selection) {
  if (selection == null) return null;

  var coordinates = selection.split(":");
  if (coordinates.length != 2) {
    throw new FormatException(
        'Selection should be a colon-separated pair of integers, "123:45".');
  }

  return coordinates.map((coord) => coord.trim()).map(int.parse).toList();
}

/// Reads input from stdin until it's closed, and the formats it.
void formatStdin(FormatterOptions options, List<int> selection) {
  var selectionStart = 0;
  var selectionLength = 0;

  if (selection != null) {
    selectionStart = selection[0];
    selectionLength = selection[1];
  }

  var input = new StringBuffer();
  stdin.transform(new Utf8Decoder()).listen(input.write, onDone: () {
    var formatter =
        new DartFormatter(indent: options.indent, pageWidth: options.pageWidth);
    try {
      options.reporter.beforeFile(null, "<stdin>");
      var source = new SourceCode(input.toString(),
          uri: "stdin",
          selectionStart: selectionStart,
          selectionLength: selectionLength);
      var output = formatter.formatSource(source);
      options.reporter.afterFile(null, "<stdin>", output,
          changed: source.text != output.text);
      return;
    } on FormatterException catch (err) {
      stderr.writeln(err.message());
      exitCode = 65; // sysexits.h: EX_DATAERR
    } catch (err, stack) {
      stderr.writeln('''Hit a bug in the formatter when formatting stdin.
Please report at: github.com/dart-lang/dart_style/issues
$err
$stack''');
      exitCode = 70; // sysexits.h: EX_SOFTWARE
    }
  });
}

/// Formats all of the files and directories given by [paths].
void formatPaths(FormatterOptions options, List<String> paths) {
  for (var path in paths) {
    var directory = new Directory(path);
    if (directory.existsSync()) {
      if (!processDirectory(options, directory)) {
        exitCode = 65;
      }
      continue;
    }

    var file = new File(path);
    if (file.existsSync()) {
      if (!processFile(options, file)) {
        exitCode = 65;
      }
    } else {
      stderr.writeln('No file or directory found at "$path".');
    }
  }
}

/// Prints [error] and usage help then exits with exit code 64.
void usageError(ArgParser parser, String error) {
  printUsage(parser, error);
  exit(64);
}

void printUsage(ArgParser parser, [String error]) {
  var output = stdout;

  var message = "Reformats whitespace in Dart source files.";
  if (error != null) {
    message = error;
    output = stdout;
  }

  output.write("""$message

Usage: dartfmt [-n|-w] [files or directories...]

${parser.usage}
""");
}
