// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:boolean_selector/boolean_selector.dart';

import '../../backend/test_platform.dart';
import '../../frontend/timeout.dart';
import '../configuration.dart';
import 'platform_selection.dart';
import 'reporters.dart';
import 'values.dart';

/// The parser used to parse the command-line arguments.
final ArgParser _parser = (() {
  var parser = new ArgParser(allowTrailingOptions: true);

  var allPlatforms = TestPlatform.builtIn.toList()..remove(TestPlatform.vm);
  if (!Platform.isMacOS) allPlatforms.remove(TestPlatform.safari);
  if (!Platform.isWindows) allPlatforms.remove(TestPlatform.internetExplorer);

  parser.addFlag("help",
      abbr: "h", negatable: false, help: "Shows this usage information.");
  parser.addFlag("version",
      negatable: false, help: "Shows the package's version.");

  // Note that defaultsTo declarations here are only for documentation purposes.
  // We pass null values rather than defaults to [new Configuration] so that it
  // merges properly with the config file.

  parser.addSeparator("======== Selecting Tests");
  parser.addOption("name",
      abbr: 'n',
      help: 'A substring of the name of the test to run.\n'
          'Regular expression syntax is supported.\n'
          'If passed multiple times, tests must match all substrings.',
      allowMultiple: true,
      splitCommas: false);
  parser.addOption("plain-name",
      abbr: 'N',
      help: 'A plain-text substring of the name of the test to run.\n'
          'If passed multiple times, tests must match all substrings.',
      allowMultiple: true,
      splitCommas: false);
  parser.addOption("tags",
      abbr: 't',
      help: 'Run only tests with all of the specified tags.\n'
          'Supports boolean selector syntax.',
      allowMultiple: true);
  parser.addOption("tag", hide: true, allowMultiple: true);
  parser.addOption("exclude-tags",
      abbr: 'x',
      help: "Don't run tests with any of the specified tags.\n"
          "Supports boolean selector syntax.",
      allowMultiple: true);
  parser.addOption("exclude-tag", hide: true, allowMultiple: true);
  parser.addFlag("run-skipped",
      help: 'Run skipped tests instead of skipping them.');

  parser.addSeparator("======== Running Tests");
  parser.addOption("platform",
      abbr: 'p',
      help: 'The platform(s) on which to run the tests.\n'
          '[vm (default), '
          '${allPlatforms.map((platform) => platform.identifier).join(", ")}]',
      allowMultiple: true);
  parser.addOption("preset",
      abbr: 'P',
      help: 'The configuration preset(s) to use.',
      allowMultiple: true);
  parser.addOption("concurrency",
      abbr: 'j',
      help: 'The number of concurrent test suites run.',
      defaultsTo: defaultConcurrency.toString(),
      valueHelp: 'threads');
  parser.addOption("pub-serve",
      help: 'The port of a pub serve instance serving "test/".',
      valueHelp: 'port');
  parser.addOption("timeout",
      help: 'The default test timeout. For example: 15s, 2x, none',
      defaultsTo: '30s');
  parser.addFlag("pause-after-load",
      help: 'Pauses for debugging before any tests execute.\n'
          'Implies --concurrency=1 and --timeout=none.\n'
          'Currently only supported for browser tests.',
      negatable: false);
  parser.addFlag("chain-stack-traces",
      help: 'Chained stack traces to provide greater exception details\n'
          'especially for asynchronous code. It may be useful to disable\n'
          'to provide improved test performance but at the cost of\n'
          'debuggability.',
      defaultsTo: true);
  parser.addFlag("no-retry",
      help: "Don't re-run tests that have retry set.",
      defaultsTo: false,
      negatable: false);

  var reporterDescriptions = <String, String>{};
  for (var reporter in allReporters.keys) {
    reporterDescriptions[reporter] = allReporters[reporter].description;
  }

  parser.addSeparator("======== Output");
  parser.addOption("reporter",
      abbr: 'r',
      help: 'The runner used to print test results.',
      defaultsTo: defaultReporter,
      allowed: reporterDescriptions.keys.toList(),
      allowedHelp: reporterDescriptions);
  parser.addFlag("verbose-trace",
      negatable: false,
      help: 'Whether to emit stack traces with core library frames.');
  parser.addFlag("js-trace",
      negatable: false,
      help: 'Whether to emit raw JavaScript stack traces for browser tests.');
  parser.addFlag("color",
      help: 'Whether to use terminal colors.\n(auto-detected by default)');

  /// The following options are used only by the internal Google test runner.
  /// They're hidden and not supported as stable API surface outside Google.

  parser.addOption("configuration",
      help: 'The path to the configuration file.', hide: true);
  parser.addOption("dart2js-path",
      help: 'The path to the dart2js executable.', hide: true);
  parser.addOption("dart2js-args",
      help: 'Extra arguments to pass to dart2js.',
      allowMultiple: true,
      hide: true);
  parser.addOption("total-shards",
      help: 'The total number of invocations of the test runner being run.',
      hide: true);
  parser.addOption("shard-index",
      help: 'The index of this test runner invocation (of --total-shards).',
      hide: true);

  // If we're running test/dir/my_test.dart, we'll look for
  // test/dir/my_test.dart.html in the precompiled directory.
  parser.addOption("precompiled",
      help: 'The path to a mirror of the package directory containing HTML '
          'that points to precompiled JS.',
      hide: true);

  return parser;
})();

/// The usage string for the command-line arguments.
String get usage => _parser.usage;

/// Parses the configuration from [args].
///
/// Throws a [FormatException] if [args] are invalid.
Configuration parse(List<String> args) => new _Parser(args).parse();

/// A class for parsing an argument list.
///
/// This is used to provide access to the arg results across helper methods.
class _Parser {
  /// The parsed options.
  final ArgResults _options;

  _Parser(List<String> args) : _options = _parser.parse(args);

  /// Returns the parsed configuration.
  Configuration parse() {
    var patterns = (_options['name'] as List<String>)
        .map<Pattern>(
            (value) => _wrapFormatException('name', () => new RegExp(value)))
        .toList()
          ..addAll(_options['plain-name'] as List<String>);

    var includeTagSet = new Set.from(_options['tags'] ?? [])
      ..addAll(_options['tag'] ?? []);

    var includeTags = includeTagSet.fold(BooleanSelector.all, (selector, tag) {
      var tagSelector = new BooleanSelector.parse(tag);
      return selector.intersection(tagSelector);
    });

    var excludeTagSet = new Set.from(_options['exclude-tags'] ?? [])
      ..addAll(_options['exclude-tag'] ?? []);

    var excludeTags = excludeTagSet.fold(BooleanSelector.none, (selector, tag) {
      var tagSelector = new BooleanSelector.parse(tag);
      return selector.union(tagSelector);
    });

    var shardIndex = _parseOption('shard-index', int.parse);
    var totalShards = _parseOption('total-shards', int.parse);
    if ((shardIndex == null) != (totalShards == null)) {
      throw new FormatException(
          "--shard-index and --total-shards may only be passed together.");
    } else if (shardIndex != null) {
      if (shardIndex < 0) {
        throw new FormatException("--shard-index may not be negative.");
      } else if (shardIndex >= totalShards) {
        throw new FormatException(
            "--shard-index must be less than --total-shards.");
      }
    }

    return new Configuration(
        help: _ifParsed('help'),
        version: _ifParsed('version'),
        verboseTrace: _ifParsed('verbose-trace'),
        chainStackTraces: _ifParsed('chain-stack-traces'),
        jsTrace: _ifParsed('js-trace'),
        pauseAfterLoad: _ifParsed('pause-after-load'),
        color: _ifParsed('color'),
        configurationPath: _ifParsed('configuration'),
        dart2jsPath: _ifParsed('dart2js-path'),
        dart2jsArgs: _ifParsed('dart2js-args') as List<String>,
        precompiledPath: _ifParsed('precompiled'),
        reporter: _ifParsed('reporter'),
        pubServePort: _parseOption('pub-serve', int.parse),
        concurrency: _parseOption('concurrency', int.parse),
        shardIndex: shardIndex,
        totalShards: totalShards,
        timeout: _parseOption('timeout', (value) => new Timeout.parse(value)),
        patterns: patterns,
        platforms: (_ifParsed('platform') as List<String>)
            ?.map((platform) => new PlatformSelection(platform))
            ?.toList(),
        runSkipped: _ifParsed('run-skipped'),
        chosenPresets: _ifParsed('preset') as List<String>,
        paths: _options.rest.isEmpty ? null : _options.rest,
        includeTags: includeTags,
        excludeTags: excludeTags,
        noRetry: _ifParsed('no-retry'));
  }

  /// Returns the parsed option for [name], or `null` if none was parsed.
  ///
  /// If the user hasn't explicitly chosen a value, we want to pass null values
  /// to [new Configuration] so that it considers those fields unset when
  /// merging with configuration from the config file.
  _ifParsed(String name) => _options.wasParsed(name) ? _options[name] : null;

  /// Runs [parse] on the value of the option [name], and wraps any
  /// [FormatException] it throws with additional information.
  T _parseOption<T>(String name, T parse(String value)) {
    if (!_options.wasParsed(name)) return null;

    var value = _options[name];
    if (value == null) return null;

    return _wrapFormatException(name, () => parse(value as String));
  }

  /// Runs [parse], and wraps any [FormatException] it throws with additional
  /// information.
  T _wrapFormatException<T>(String name, T parse()) {
    try {
      return parse();
    } on FormatException catch (error) {
      throw new FormatException('Couldn\'t parse --$name "${_options[name]}": '
          '${error.message}');
    }
  }
}
