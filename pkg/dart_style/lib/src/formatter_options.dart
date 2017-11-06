// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dart_style.src.formatter_options;

import 'dart:convert';
import 'dart:io';

import 'source_code.dart';

/// Global options that affect how the formatter produces and uses its outputs.
class FormatterOptions {
  /// The [OutputReporter] used to show the formatting results.
  final OutputReporter reporter;

  /// The number of spaces of indentation to prefix the output with.
  final int indent;

  /// The number of columns that formatted output should be constrained to fit
  /// within.
  final int pageWidth;

  /// Whether symlinks should be traversed when formatting a directory.
  final bool followLinks;

  FormatterOptions(this.reporter,
      {this.indent: 0, this.pageWidth: 80, this.followLinks: false});
}

/// How the formatter reports the results it produces.
abstract class OutputReporter {
  /// Prints only the names of files whose contents are different from their
  /// formatted version.
  static final OutputReporter dryRun = new _DryRunReporter();

  /// Prints the formatted results of each file to stdout.
  static final OutputReporter print = new _PrintReporter();

  /// Prints the formatted result and selection info of each file to stdout as
  /// a JSON map.
  static final OutputReporter printJson = new _PrintJsonReporter();

  /// Overwrites each file with its formatted result.
  static final OutputReporter overwrite = new _OverwriteReporter();

  /// Describe the directory whose contents are about to be processed.
  void showDirectory(String path) {}

  /// Describe the symlink at [path] that wasn't followed.
  void showSkippedLink(String path) {}

  /// Describe the hidden [path] that wasn't processed.
  void showHiddenPath(String path) {}

  /// Called when [file] is about to be formatted.
  void beforeFile(File file, String label) {}

  /// Describe the processed file at [path] whose formatted result is [output].
  ///
  /// If the contents of the file are the same as the formatted output,
  /// [changed] will be false.
  void afterFile(File file, String label, SourceCode output, {bool changed});
}

/// Prints only the names of files whose contents are different from their
/// formatted version.
class _DryRunReporter extends OutputReporter {
  void afterFile(File file, String label, SourceCode output, {bool changed}) {
    // Only show the changed files.
    if (changed) print(label);
  }
}

/// Prints the formatted results of each file to stdout.
class _PrintReporter extends OutputReporter {
  void showDirectory(String path) {
    print("Formatting directory $path:");
  }

  void showSkippedLink(String path) {
    print("Skipping link $path");
  }

  void showHiddenPath(String path) {
    print("Skipping hidden path $path");
  }

  void afterFile(File file, String label, SourceCode output, {bool changed}) {
    // Don't add an extra newline.
    stdout.write(output.text);
  }
}

/// Prints the formatted result and selection info of each file to stdout as a
/// JSON map.
class _PrintJsonReporter extends OutputReporter {
  void afterFile(File file, String label, SourceCode output, {bool changed}) {
    // TODO(rnystrom): Put an empty selection in here to remain compatible with
    // the old formatter. Since there's no way to pass a selection on the
    // command line, this will never be used, which is why it's hard-coded to
    // -1, -1. If we add support for passing in a selection, put the real
    // result here.
    print(JSON.encode({
      "path": label,
      "source": output.text,
      "selection": {
        "offset": output.selectionStart != null ? output.selectionStart : -1,
        "length": output.selectionLength != null ? output.selectionLength : -1
      }
    }));
  }
}

/// Overwrites each file with its formatted result.
class _OverwriteReporter extends _PrintReporter {
  void afterFile(File file, String label, SourceCode output, {bool changed}) {
    if (changed) {
      try {
        file.writeAsStringSync(output.text);
        print("Formatted $label");
      } on FileSystemException catch (err) {
        stderr.writeln("Could not overwrite $label: "
            "${err.osError.message} (error code ${err.osError.errorCode})");
      }
    } else {
      print("Unchanged $label");
    }
  }
}

/// Base clase for a reporter that decorates an inner reporter.
abstract class _ReporterDecorator implements OutputReporter {
  final OutputReporter _inner;

  _ReporterDecorator(this._inner);

  void showDirectory(String path) {
    _inner.showDirectory(path);
  }

  void showSkippedLink(String path) {
    _inner.showSkippedLink(path);
  }

  void showHiddenPath(String path) {
    _inner.showHiddenPath(path);
  }

  void beforeFile(File file, String label) {
    _inner.beforeFile(file, label);
  }

  void afterFile(File file, String label, SourceCode output, {bool changed}) {
    _inner.afterFile(file, label, output, changed: changed);
  }
}

/// A decorating reporter that reports how long it took for format each file.
class ProfileReporter extends _ReporterDecorator {
  /// The files that have been started but have not completed yet.
  ///
  /// Maps a file label to the time that it started being formatted.
  final Map<String, DateTime> _ongoing = {};

  /// The elapsed time it took to format each completed file.
  final Map<String, Duration> _elapsed = {};

  /// The number of files that completed so fast that they aren't worth
  /// tracking.
  int _elided = 0;

  ProfileReporter(OutputReporter inner) : super(inner);

  /// Show the times for the slowest files to format.
  void showProfile() {
    // Everything should be done.
    assert(_ongoing.isEmpty);

    var files = _elapsed.keys.toList();
    files.sort((a, b) => _elapsed[b].compareTo(_elapsed[a]));

    for (var file in files) {
      print("${_elapsed[file]}: $file");
    }

    if (_elided >= 1) {
      var s = _elided > 1 ? 's' : '';
      print("...$_elided more file$s each took less than 10ms.");
    }
  }

  /// Called when [file] is about to be formatted.
  void beforeFile(File file, String label) {
    super.beforeFile(file, label);
    _ongoing[label] = new DateTime.now();
  }

  /// Describe the processed file at [path] whose formatted result is [output].
  ///
  /// If the contents of the file are the same as the formatted output,
  /// [changed] will be false.
  void afterFile(File file, String label, SourceCode output, {bool changed}) {
    var elapsed = new DateTime.now().difference(_ongoing.remove(label));
    if (elapsed.inMilliseconds >= 10) {
      _elapsed[label] = elapsed;
    } else {
      _elided++;
    }

    super.afterFile(file, label, output, changed: changed);
  }
}

/// A decorating reporter that sets the exit code to 1 if any changes are made.
class SetExitReporter extends _ReporterDecorator {
  SetExitReporter(OutputReporter inner) : super(inner);

  /// Describe the processed file at [path] whose formatted result is [output].
  ///
  /// If the contents of the file are the same as the formatted output,
  /// [changed] will be false.
  void afterFile(File file, String label, SourceCode output, {bool changed}) {
    if (changed) exitCode = 1;

    super.afterFile(file, label, output, changed: changed);
  }
}
