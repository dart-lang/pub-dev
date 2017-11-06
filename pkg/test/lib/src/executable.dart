// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO(nweiz): This is under lib so that it can be used by the unittest dummy
// package. Once that package is no longer being updated, move this back into
// bin.
import 'dart:io';

import 'package:async/async.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:yaml/yaml.dart';

import 'runner.dart';
import 'runner/application_exception.dart';
import 'runner/configuration.dart';
import 'runner/version.dart';
import 'util/exit_codes.dart' as exit_codes;
import 'util/io.dart';
import 'utils.dart';

/// A merged stream of all signals that tell the test runner to shut down
/// gracefully.
///
/// Signals will only be captured as long as this has an active subscription.
/// Otherwise, they'll be handled by Dart's default signal handler, which
/// terminates the program immediately.
final _signals = Platform.isWindows
    ? ProcessSignal.SIGINT.watch()
    : StreamGroup
        .merge([ProcessSignal.SIGTERM.watch(), ProcessSignal.SIGINT.watch()]);

/// Returns whether the current package has a pubspec which uses the
/// `test/pub_serve` transformer.
bool get _usesTransformer {
  if (!new File('pubspec.yaml').existsSync()) return false;
  var contents = new File('pubspec.yaml').readAsStringSync();

  var yaml;
  try {
    yaml = loadYaml(contents);
  } on FormatException {
    return false;
  }

  if (yaml is! Map) return false;

  var transformers = yaml['transformers'];
  if (transformers == null) return false;
  if (transformers is! List) return false;

  return transformers.any((transformer) {
    if (transformer is String) return transformer == 'test/pub_serve';
    if (transformer is! Map) return false;
    if (transformer.keys.length != 1) return false;
    return transformer.keys.single == 'test/pub_serve';
  });
}

/// Returns the path to the global test configuration file.
final String _globalConfigPath = () {
  if (Platform.environment.containsKey('DART_TEST_CONFIG')) {
    return Platform.environment['DART_TEST_CONFIG'];
  } else if (Platform.operatingSystem == 'windows') {
    return p.join(Platform.environment['LOCALAPPDATA'], 'DartTest.yaml');
  } else {
    return '${Platform.environment['HOME']}/.dart_test.yaml';
  }
}();

main(List<String> args) async {
  Configuration configuration;
  try {
    configuration = new Configuration.parse(args);
  } on FormatException catch (error) {
    _printUsage(error.message);
    exitCode = exit_codes.usage;
    return;
  }

  if (configuration.help) {
    _printUsage();
    return;
  }

  if (configuration.version) {
    var version = testVersion;
    if (version == null) {
      stderr.writeln("Couldn't find version number.");
      exitCode = exit_codes.data;
    } else {
      print(version);
    }
    return;
  }

  try {
    var fileConfiguration = Configuration.empty;
    if (new File(_globalConfigPath).existsSync()) {
      fileConfiguration = fileConfiguration
          .merge(new Configuration.load(_globalConfigPath, global: true));
    }

    if (new File(configuration.configurationPath).existsSync()) {
      fileConfiguration = fileConfiguration
          .merge(new Configuration.load(configuration.configurationPath));
    }

    configuration = fileConfiguration.merge(configuration);
  } on SourceSpanFormatException catch (error) {
    stderr.writeln(error.toString(color: configuration.color));
    exitCode = exit_codes.data;
    return;
  } on FormatException catch (error) {
    stderr.writeln(error.message);
    exitCode = exit_codes.data;
    return;
  } on IOException catch (error) {
    stderr.writeln(error.toString());
    exitCode = exit_codes.noInput;
    return;
  }

  var undefinedPresets = configuration.chosenPresets
      .where((preset) => !configuration.knownPresets.contains(preset))
      .toList();
  if (undefinedPresets.isNotEmpty) {
    _printUsage("Undefined ${pluralize('preset', undefinedPresets.length)} "
        "${toSentence(undefinedPresets.map((preset) => '"$preset"'))}.");
    exitCode = exit_codes.usage;
    return;
  }

  if (configuration.pubServeUrl != null && !_usesTransformer) {
    stderr.write('''
When using --pub-serve, you must include the "test/pub_serve" transformer in
your pubspec:

transformers:
- test/pub_serve:
    \$include: test/**_test.dart
''');
    exitCode = exit_codes.data;
    return;
  }

  if (!configuration.explicitPaths &&
      !new Directory(configuration.paths.single).existsSync()) {
    _printUsage('No test files were passed and the default "test/" '
        "directory doesn't exist.");
    exitCode = exit_codes.data;
    return;
  }

  Runner runner;
  var signalSubscription;
  close() async {
    if (signalSubscription == null) return;
    signalSubscription.cancel();
    signalSubscription = null;
    stdinLines.cancel(immediate: true);
    await runner?.close();
  }

  signalSubscription = _signals.listen((_) => close());

  try {
    runner = new Runner(configuration);
    exitCode = (await runner.run()) ? 0 : 1;
  } on ApplicationException catch (error) {
    stderr.writeln(error.message);
    exitCode = exit_codes.data;
  } on SourceSpanFormatException catch (error) {
    stderr.writeln(error.toString(color: configuration.color));
    exitCode = exit_codes.data;
  } on FormatException catch (error) {
    stderr.writeln(error.message);
    exitCode = exit_codes.data;
  } catch (error, stackTrace) {
    stderr.writeln(getErrorMessage(error));
    stderr.writeln(new Trace.from(stackTrace).terse);
    stderr.writeln("This is an unexpected error. Please file an issue at "
        "http://github.com/dart-lang/test\n"
        "with the stack trace and instructions for reproducing the error.");
    exitCode = exit_codes.software;
  } finally {
    await close();
  }

  // TODO(grouma) - figure out why the executable can hang in the travis
  // environment. https://github.com/dart-lang/test/issues/599
  if (Platform.environment["FORCE_TEST_EXIT"] == "true") {
    exit(exitCode);
  }
}

/// Print usage information for this command.
///
/// If [error] is passed, it's used in place of the usage message and the whole
/// thing is printed to stderr instead of stdout.
void _printUsage([String error]) {
  var output = stdout;

  var message = "Runs tests in this package.";
  if (error != null) {
    message = error;
    output = stderr;
  }

  output.write("""${wordWrap(message)}

Usage: pub run test [files or directories...]

${Configuration.usage}
""");
}
