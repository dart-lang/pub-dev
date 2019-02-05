// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.utils;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:appengine/appengine.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
// ignore: implementation_imports
import 'package:mime/src/default_extension_map.dart' as mime;
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart' as semver;
import 'package:pub_server/repository.dart' show GenericProcessingException;
import 'package:stream_transform/stream_transform.dart';

import 'packages_overrides.dart';

export 'package:pana/src/maintenance.dart' show exampleFileCandidates;

final Duration twoYears = const Duration(days: 2 * 365);

/// The value `X-Cloud-Trace-Context`.
///
/// Standard trace header used by
/// [StackDriver](https://cloud.google.com/trace/docs/support) and supported by
/// Appengine.
const _cloudTraceContextHeader = 'X-Cloud-Trace-Context';

const fileAnIssueContent =
    'Please open an issue: https://github.com/dart-lang/pub-dartlang-dart/issues/new';

final Logger _logger = new Logger('pub.utils');

final DateFormat shortDateFormat = new DateFormat.yMMMd();

Future<T> withTempDirectory<T>(Future<T> func(Directory dir),
    {String prefix = 'dart-tempdir'}) {
  return Directory.systemTemp.createTemp(prefix).then((Directory dir) {
    return func(dir).whenComplete(() {
      return dir.delete(recursive: true);
    });
  });
}

Future<List<String>> listTarball(String path) async {
  // List files up-to 4 directory levels:
  final args = ['--exclude=*/*/*/*/*', '-tzf', path];
  final result = await Process.run('tar', args);
  if (result.exitCode != 0) {
    _logger.warning('The "tar $args" command failed:\n'
        'with exit code: ${result.exitCode}\n'
        'stdout: ${result.stdout}\n'
        'stderr: ${result.stderr}');
    throw new Exception('Failed to list tarball contents.');
  }

  return (result.stdout as String)
      .split('\n')
      .where((part) => part != '')
      .toList();
}

Future<String> readTarballFile(String path, String name,
    {int maxLength = 0}) async {
  final result = await Process.run(
    'tar',
    ['-O', '-xzf', path, name],
    stdoutEncoding: new Utf8Codec(allowMalformed: true),
  );
  if (result.exitCode != 0) {
    throw new Exception('Failed to read tarball contents.');
  }
  String content = result.stdout as String;
  if (maxLength > 0 && content.length > maxLength) {
    content = content.substring(0, maxLength) + '[...]\n\n';
  }
  return content;
}

String canonicalizeVersion(String version) {
  // NOTE: This is a hack because [semver.Version.parse] does not remove
  // leading zeros for integer fields.
  final v = new semver.Version.parse(version);
  final pre = v.preRelease != null && v.preRelease.isNotEmpty
      ? v.preRelease.join('.')
      : null;
  final build =
      v.build != null && v.build.isNotEmpty ? v.build.join('.') : null;

  final canonicalVersion =
      new semver.Version(v.major, v.minor, v.patch, pre: pre, build: build);

  if (v != canonicalVersion) {
    throw new StateError(
        'This should never happen: Canonicalization of versions is wrong.');
  }
  return canonicalVersion.toString();
}

/// Compares two versions according to the semantic versioning specification.
///
/// If [pubSorted] is `true` then pub's priorization ordering is used, which
/// will rank pre-release versions lower than stable versions (e.g. it will
/// order "0.9.0-dev.1 < 0.8.0").  Otherwise it will use semantic version
/// sorting (e.g. it will order "0.8.0 < 0.9.0-dev.1").
int compareSemanticVersionsDesc(
    semver.Version a, semver.Version b, bool decreasing, bool pubSorted) {
  if (pubSorted) {
    if (decreasing) {
      return semver.Version.prioritize(b, a);
    } else {
      return semver.Version.prioritize(a, b);
    }
  } else {
    if (decreasing) {
      return b.compareTo(a);
    } else {
      return a.compareTo(b);
    }
  }
}

/// Returns true if [b] is considered newer than [a].
///
/// If [pubSorted] is `true` then pub's priorization ordering is used, which
/// will rank pre-release versions lower than stable versions (e.g. it will
/// order "0.9.0-dev.1 < 0.8.0").  Otherwise it will use semantic version
/// sorting (e.g. it will order "0.8.0 < 0.9.0-dev.1").
bool isNewer(semver.Version a, semver.Version b, {bool pubSorted = true}) =>
    compareSemanticVersionsDesc(a, b, false, pubSorted) < 0;

final RegExp _identifierExpr = new RegExp(r'^[a-zA-Z0-9_]+$');
final RegExp _startsWithLetterOrUnderscore = new RegExp(r'^[a-zA-Z_]');
const List<String> _reservedWords = const <String>[
  'assert',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'default',
  'do',
  'else',
  'extends',
  'false',
  'final',
  'finally',
  'for',
  'if',
  'in',
  'is',
  'mixin',
  'new',
  'null',
  'return',
  'super',
  'switch',
  'this',
  'throw',
  'true',
  'try',
  'var',
  'void',
  'while',
  'with'
];

final _reservedPackageNames = <String>[
  'core',
  'google_maps_flutter',
  'hummingbird',
  'in_app_purchase',
  'location_background',
  'math',
  'versions',
  'webview_flutter',
].map(reducePackageName).toList();

/// Whether the [name] is (very similar) to a reserved package name.
bool matchesReservedPackageName(String name) =>
    _reservedPackageNames.contains(reducePackageName(name));

/// Sanity checks if the user would upload a package with a modified pub client
/// that skips these verifications.
/// TODO: share code to use the same validations as in
/// https://github.com/dart-lang/pub/blob/master/lib/src/validator/name.dart#L52
void validatePackageName(String name) {
  if (!_identifierExpr.hasMatch(name)) {
    throw new GenericProcessingException(
        'Package name may only contain letters, numbers, and underscores.');
  }
  if (!_startsWithLetterOrUnderscore.hasMatch(name)) {
    throw new GenericProcessingException(
        'Package name must begin with a letter or underscore.');
  }
  if (_reservedWords.contains(reducePackageName(name))) {
    throw new GenericProcessingException(
        'Package name must not be a reserved word in Dart.');
  }
  final bool isLower = name == name.toLowerCase();
  final bool matchesMixedCase = knownMixedCasePackages.contains(name);
  if (!isLower && !matchesMixedCase) {
    throw new GenericProcessingException('Package name must be lowercase.');
  }
  if (isLower && blockedLowerCasePackages.contains(name)) {
    throw new GenericProcessingException(
        'Name collision with mixed-case package. $fileAnIssueContent');
  }
  if (!isLower &&
      matchesMixedCase &&
      !blockedLowerCasePackages.contains(name.toLowerCase())) {
    throw new GenericProcessingException(
        'Name collision with mixed-case package. $fileAnIssueContent');
  }
}

/// Removes extra characters from the package name
String reducePackageName(String name) =>
    // we allow only `_` as part of the name.
    name.replaceAll('_', '').toLowerCase();

List<List<T>> _sliceList<T>(List<T> list, int limit) {
  if (list.length <= limit) return [list];
  final int maxPageIndex = (list.length - 1) ~/ limit;
  return new List.generate(maxPageIndex + 1,
      (p) => list.sublist(p * limit, min(list.length, (p + 1) * limit)));
}

/// Buffers for [duration] and then randomizes the order of the items in the
/// stream. For every single item, their final position would be in the range of
/// [maxPositionDiff] of its original position.
Stream<T> randomizeStream<T>(
  Stream<T> stream, {
  Duration duration = const Duration(minutes: 1),
  int maxPositionDiff = 1000,
  Random random,
}) {
  random ??= new Random.secure();
  final Stream trigger = new Stream.periodic(duration);
  final Stream<List<T>> bufferedStream = buffer<T>(trigger).bind(stream);
  return bufferedStream.transform(new StreamTransformer.fromHandlers(
    handleData: (List<T> items, Sink<T> sink) {
      for (List<T> list in _sliceList(items, maxPositionDiff)) {
        list.shuffle(random);
        for (T task in list) {
          sink.add(task);
        }
      }
    },
  ));
}

class LastNTracker<T extends Comparable<T>> {
  final Queue<T> _lastItems = new Queue();
  final int _n;

  LastNTracker({int lastN = 1000}) : _n = lastN;

  void add(T d) {
    _lastItems.addLast(d);
    if (_lastItems.length > _n) _lastItems.removeFirst();
  }

  T get median => _getP(0.5);
  T get p90 => _getP(0.9);
  T get p99 => _getP(0.99);

  Map<T, int> toCounts() {
    return _lastItems.fold<Map<T, int>>({}, (Map<T, int> m, T item) {
      m[item] = (m[item] ?? 0) + 1;
      return m;
    });
  }

  double get average {
    if (_lastItems.isEmpty) return 0.0;
    final double sum = _lastItems
        .where((item) => item is num)
        .fold(0.0, (a, b) => a + (b as num));
    return sum / _lastItems.length;
  }

  T _getP(double p) {
    if (_lastItems.isEmpty) return null;
    final List<T> list = new List.from(_lastItems);
    list.sort();
    return list[(list.length * p).floor()];
  }
}

class DurationTracker extends LastNTracker<Duration> {
  Map toShortStat() => {
        'median': median?.inMilliseconds,
        'p90': p90?.inMilliseconds,
        'p99': p99?.inMilliseconds,
      };
}

String formatDuration(Duration d) {
  final List<String> parts = [];
  int minutes = d.inMinutes;
  if (minutes == 0) return '0 mins';

  int hours = minutes ~/ 60;
  minutes = minutes % 60;
  final int days = hours ~/ 24;
  hours = hours % 24;

  if (days > 0) parts.add('$days days');
  if (hours > 0) parts.add('$hours hours');
  if (minutes > 0) parts.add('$minutes mins');

  return parts.join(' ');
}

Future<http.Response> getUrlWithRetry(http.Client client, String url,
    {int retryCount = 1, Duration timeout}) async {
  http.Response result;
  Map<String, String> headers;
  if (context?.traceId != null) {
    headers = {_cloudTraceContextHeader: context.traceId};
  }
  for (int i = 0; i <= retryCount; i++) {
    try {
      _logger.info('HTTP GET $url');
      Future<http.Response> future = client.get(url, headers: headers);
      if (timeout != null) {
        future = future.timeout(timeout);
      }
      result = await future;
      if (i == retryCount ||
          result.statusCode == 200 ||
          result.statusCode == 404) {
        return result;
      }
    } catch (e, st) {
      _logger.warning(
          'HTTP GET failed on $url (${retryCount - i} retry left)', e, st);
      if (i == retryCount) rethrow;
    }
    if (i < retryCount) {
      await new Future.delayed(const Duration(seconds: 1));
    }
  }
  return result;
}

/// To avoid having the same String values many times in memory we intern them.
/// https://en.wikipedia.org/wiki/String_interning
class StringInternPool {
  final Map<String, String> _values = <String, String>{};

  String intern(String value) => _values.putIfAbsent(value, () => value);

  void checkUnboundGrowth() {
    if (_values.length > 100000) {
      _values.clear();
    }
  }
}

/// Returns the MIME content type based on the name of the file.
String contentType(String name) {
  final ext = p.extension(name).replaceAll('.', '');
  return mime.defaultExtensionMap[ext] ?? 'application/octet-stream';
}

final eventLoopLatencyTracker = new LastNTracker<Duration>();

void trackEventLoopLatency() {
  final samplePeriod = const Duration(seconds: 3);
  void measure() {
    final sw = new Stopwatch()..start();
    new Timer(samplePeriod, () {
      sw.stop();
      final diff = sw.elapsed - samplePeriod;
      final latency = diff.isNegative ? Duration.zero : diff;
      eventLoopLatencyTracker.add(latency);
      measure();
    });
  }

  Zone.root.run(() {
    measure();
  });
}

/// Returns a subset of the list, bounded by [offset] and [limit].
List<T> boundedList<T>(List<T> list, {int offset, int limit}) {
  if (list == null) return null;
  Iterable<T> iterable = list;
  if (offset != null && offset > 0) {
    if (offset >= list.length) {
      return <T>[];
    } else {
      iterable = iterable.skip(offset);
    }
  }
  if (limit != null && limit > 0) {
    iterable = iterable.take(limit);
  }
  return iterable.toList();
}

/// Executes [body] and returns with the same result.
/// When it throws an exception, it will be re-run until [maxAttempt] is reached.
Future<R> retryAsync<R>(
  Future<R> body(), {
  int maxAttempt = 3,
  bool shouldRetryOnError(error),
  String description = 'Async operation',
  Duration sleep = const Duration(seconds: 1),
}) async {
  for (int i = 1;; i++) {
    try {
      return await body();
    } catch (e, st) {
      _logger.info('$description failed (attempt: $i of $maxAttempt).', e, st);
      if (i < maxAttempt &&
          (shouldRetryOnError == null || shouldRetryOnError(e))) {
        await new Future.delayed(sleep);
        continue;
      }
      rethrow;
    }
  }
}
