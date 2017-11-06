// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';

import 'backend/group.dart';
import 'backend/group_entry.dart';
import 'backend/operating_system.dart';
import 'backend/platform_selector.dart';
import 'backend/suite.dart';
import 'backend/test.dart';
import 'backend/test_platform.dart';
import 'runner/application_exception.dart';
import 'runner/configuration.dart';
import 'runner/configuration/reporters.dart';
import 'runner/debugger.dart';
import 'runner/engine.dart';
import 'runner/load_exception.dart';
import 'runner/load_suite.dart';
import 'runner/loader.dart';
import 'runner/reporter.dart';
import 'runner/reporter/compact.dart';
import 'runner/reporter/expanded.dart';
import 'util/io.dart';
import 'utils.dart';

/// A class that loads and runs tests based on a [Configuration].
///
/// This maintains a [Loader] and an [Engine] and passes test suites from one to
/// the other, as well as printing out tests with a [CompactReporter] or an
/// [ExpandedReporter].
class Runner {
  /// The test runner configuration.
  final _config = Configuration.current;

  /// The loader that loads the test suites from the filesystem.
  final _loader = new Loader();

  /// The engine that runs the test suites.
  final Engine _engine;

  /// The reporter that's emitting the test runner's results.
  final Reporter _reporter;

  /// The subscription to the stream returned by [_loadSuites].
  StreamSubscription _suiteSubscription;

  /// The set of suite paths for which [_warnForUnknownTags] has already been
  /// called.
  ///
  /// This is used to avoid printing duplicate warnings when a suite is loaded
  /// on multiple platforms.
  final _tagWarningSuites = new Set<String>();

  /// The current debug operation, if any.
  ///
  /// This is stored so that we can cancel it when the runner is closed.
  CancelableOperation _debugOperation;

  /// The memoizer for ensuring [close] only runs once.
  final _closeMemo = new AsyncMemoizer();
  bool get _closed => _closeMemo.hasRun;

  /// Creates a new runner based on [configuration].
  factory Runner(Configuration config) => config.asCurrent(() {
        var engine = new Engine(concurrency: config.concurrency);

        var reporterDetails = allReporters[config.reporter];
        return new Runner._(engine, reporterDetails.factory(config, engine));
      });

  Runner._(this._engine, this._reporter);

  /// Starts the runner.
  ///
  /// This starts running tests and printing their progress. It returns whether
  /// or not they ran successfully.
  Future<bool> run() => _config.asCurrent(() async {
        if (_closed) {
          throw new StateError("run() may not be called on a closed Runner.");
        }

        _warnForUnsupportedPlatforms();

        var suites = _loadSuites();

        var success;
        if (_config.pauseAfterLoad) {
          success = await _loadThenPause(suites);
        } else {
          _suiteSubscription = suites.listen(_engine.suiteSink.add);
          var results = await Future.wait(<Future>[
            _suiteSubscription
                .asFuture()
                .then((_) => _engine.suiteSink.close()),
            _engine.run()
          ], eagerError: true);
          success = results.last;
        }

        if (_closed) return false;

        if (_engine.passed.length == 0 &&
            _engine.failed.length == 0 &&
            _engine.skipped.length == 0 &&
            _config.suiteDefaults.patterns.isNotEmpty) {
          var patterns = toSentence(_config.suiteDefaults.patterns.map(
              (pattern) => pattern is RegExp
                  ? 'regular expression "${pattern.pattern}"'
                  : '"$pattern"'));

          throw new ApplicationException('No tests match $patterns.');
        }

        // Explicitly check "== true" here because [Engine.run] can return `null`
        // if the engine was closed prematurely.
        return success == true;
      });

  /// Emits a warning if the user is trying to run on a platform that's
  /// unsupported for the entire package.
  void _warnForUnsupportedPlatforms() {
    var testOn = _config.suiteDefaults.metadata.testOn;
    if (testOn == PlatformSelector.all) return;

    var unsupportedPlatforms = _config.suiteDefaults.platforms
        .map(_loader.findTestPlatform)
        .where((platform) =>
            platform != null && !testOn.evaluate(platform, os: currentOS))
        .toList();
    if (unsupportedPlatforms.isEmpty) return;

    // Human-readable names for all unsupported platforms.
    var unsupportedNames = [];

    // If the user tried to run on one or moe unsupported browsers, figure out
    // whether we should warn about the individual browsers or whether all
    // browsers are unsupported.
    var unsupportedBrowsers =
        unsupportedPlatforms.where((platform) => platform.isBrowser);
    if (unsupportedBrowsers.isNotEmpty) {
      var supportsAnyBrowser = _loader.allPlatforms
          .where((platform) => platform.isBrowser)
          .any((platform) => testOn.evaluate(platform));

      if (supportsAnyBrowser) {
        unsupportedNames
            .addAll(unsupportedBrowsers.map((platform) => platform.name));
      } else {
        unsupportedNames.add("browsers");
      }
    }

    // If the user tried to run on the VM and it's not supported, figure out if
    // that's because of the current OS or whether the VM is unsupported.
    if (unsupportedPlatforms.contains(TestPlatform.vm)) {
      var supportsAnyOS = OperatingSystem.all
          .any((os) => testOn.evaluate(TestPlatform.vm, os: os));

      if (supportsAnyOS) {
        unsupportedNames.add(currentOS.name);
      } else {
        unsupportedNames.add("the Dart VM");
      }
    }

    warn("this package doesn't support running tests on " +
        toSentence(unsupportedNames, conjunction: "or") +
        ".");
  }

  /// Closes the runner.
  ///
  /// This stops any future test suites from running. It will wait for any
  /// currently-running VM tests, in case they have stuff to clean up on the
  /// filesystem.
  Future close() => _closeMemo.runOnce(() async {
        var timer;
        if (!_engine.isIdle) {
          // Wait a bit to print this message, since printing it eagerly looks weird
          // if the tests then finish immediately.
          timer = new Timer(new Duration(seconds: 1), () {
            // Pause the reporter while we print to ensure that we don't interfere
            // with its output.
            _reporter.pause();
            print("Waiting for current test(s) to finish.");
            print("Press Control-C again to terminate immediately.");
            _reporter.resume();
          });
        }

        if (_debugOperation != null) await _debugOperation.cancel();

        if (_suiteSubscription != null) _suiteSubscription.cancel();
        _suiteSubscription = null;

        // Make sure we close the engine *before* the loader. Otherwise,
        // LoadSuites provided by the loader may get into bad states.
        //
        // We close the loader's browsers while we're closing the engine because
        // browser tests don't store any state we care about and we want them to
        // shut down without waiting for their tear-downs.
        await Future.wait([_loader.closeEphemeral(), _engine.close()]);
        if (timer != null) timer.cancel();
        await _loader.close();
      });

  /// Return a stream of [LoadSuite]s in [_config.paths].
  ///
  /// Only tests that match [_config.patterns] will be included in the
  /// suites once they're loaded.
  Stream<LoadSuite> _loadSuites() {
    return StreamGroup.merge(_config.paths.map((path) {
      if (new Directory(path).existsSync()) {
        return _loader.loadDir(path, _config.suiteDefaults);
      } else if (new File(path).existsSync()) {
        return _loader.loadFile(path, _config.suiteDefaults);
      } else {
        return new Stream.fromIterable([
          new LoadSuite.forLoadException(
              new LoadException(path, 'Does not exist.'), _config.suiteDefaults)
        ]);
      }
    })).map((loadSuite) {
      return loadSuite.changeSuite((suite) {
        _warnForUnknownTags(suite);

        return _shardSuite(suite.filter((test) {
          // Skip any tests that don't match all the given patterns.
          if (!suite.config.patterns
              .every((pattern) => test.name.contains(pattern))) {
            return false;
          }

          // If the user provided tags, skip tests that don't match all of them.
          if (!suite.config.includeTags.evaluate(test.metadata.tags)) {
            return false;
          }

          // Skip tests that do match any tags the user wants to exclude.
          if (suite.config.excludeTags.evaluate(test.metadata.tags)) {
            return false;
          }

          return true;
        }));
      });
    });
  }

  /// Prints a warning for any unknown tags referenced in [suite] or its
  /// children.
  void _warnForUnknownTags(Suite suite) {
    if (_tagWarningSuites.contains(suite.path)) return;
    _tagWarningSuites.add(suite.path);

    var unknownTags = _collectUnknownTags(suite);
    if (unknownTags.isEmpty) return;

    var yellow = _config.color ? '\u001b[33m' : '';
    var bold = _config.color ? '\u001b[1m' : '';
    var noColor = _config.color ? '\u001b[0m' : '';

    var buffer = new StringBuffer()
      ..write("${yellow}Warning:$noColor ")
      ..write(unknownTags.length == 1 ? "A tag was " : "Tags were ")
      ..write("used that ")
      ..write(unknownTags.length == 1 ? "wasn't " : "weren't ")
      ..writeln("specified in dart_test.yaml.");

    unknownTags.forEach((tag, entries) {
      buffer.write("  $bold$tag$noColor was used in");

      if (entries.length == 1) {
        buffer.writeln(" ${_entryDescription(entries.single)}");
        return;
      }

      buffer.write(":");
      for (var entry in entries) {
        buffer.write("\n    ${_entryDescription(entry)}");
      }
      buffer.writeln();
    });

    print(buffer.toString());
  }

  /// Collects all tags used by [suite] or its children that aren't also passed
  /// on the command line.
  ///
  /// This returns a map from tag names to lists of entries that use those tags.
  Map<String, List<GroupEntry>> _collectUnknownTags(Suite suite) {
    var unknownTags = <String, List<GroupEntry>>{};
    var currentTags = new Set<String>();

    collect(entry) {
      var newTags = new Set<String>();
      for (var unknownTag
          in entry.metadata.tags.difference(_config.knownTags)) {
        if (currentTags.contains(unknownTag)) continue;
        unknownTags.putIfAbsent(unknownTag, () => []).add(entry);
        newTags.add(unknownTag);
      }

      if (entry is! Group) return;

      currentTags.addAll(newTags);
      for (var child in entry.entries) {
        collect(child);
      }
      currentTags.removeAll(newTags);
    }

    collect(suite.group);
    return unknownTags;
  }

  /// Returns a human-readable description of [entry], including its type.
  String _entryDescription(GroupEntry entry) {
    if (entry is Test) return 'the test "${entry.name}"';
    if (entry.name != null) return 'the group "${entry.name}"';
    return 'the suite itself';
  }

  /// If sharding is enabled, filters [suite] to only include the tests that
  /// should be run in this shard.
  ///
  /// We just take a slice of the tests in each suite corresponding to the shard
  /// index. This makes the tests pretty tests across shards, and since the
  /// tests are continuous, makes us more likely to be able to re-use
  /// `setUpAll()` logic.
  Suite _shardSuite(Suite suite) {
    if (_config.totalShards == null) return suite;

    var shardSize = suite.group.testCount / _config.totalShards;
    var shardStart = (shardSize * _config.shardIndex).round();
    var shardEnd = (shardSize * (_config.shardIndex + 1)).round();

    var count = -1;
    var filtered = suite.filter((test) {
      count++;
      return count >= shardStart && count < shardEnd;
    });

    return filtered;
  }

  /// Loads each suite in [suites] in order, pausing after load for platforms
  /// that support debugging.
  Future<bool> _loadThenPause(Stream<LoadSuite> suites) async {
    if (_config.suiteDefaults.platforms.contains(TestPlatform.vm.identifier)) {
      warn("Debugging is currently unsupported on the Dart VM.",
          color: _config.color);
    }

    _suiteSubscription = suites.asyncMap((loadSuite) async {
      _debugOperation = debug(_engine, _reporter, loadSuite);
      await _debugOperation.valueOrCancellation();
    }).listen(null);

    var results = await Future.wait(<Future>[
      _suiteSubscription.asFuture().then((_) => _engine.suiteSink.close()),
      _engine.run()
    ], eagerError: true);
    return results.last;
  }
}
