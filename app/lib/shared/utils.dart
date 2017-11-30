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
import 'package:gcloud/storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart' as semver;
import 'package:stream_transform/stream_transform.dart';

/// The value `X-Cloud-Trace-Context`.
///
/// Standard trace header used by
/// [StackDriver](https://cloud.google.com/trace/docs/support) and supported by
/// Appengine.
const _cloudTraceContextHeader = 'X-Cloud-Trace-Context';

final Logger _logger = new Logger('pub.utils');

final DateFormat shortDateFormat = new DateFormat.yMMMd();

Future<T> withTempDirectory<T>(Future<T> func(Directory dir),
    {String prefix: 'dart-tempdir'}) {
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
    throw 'Failed to list tarball contents.';
  }

  return result.stdout.split('\n').where((part) => part != '').toList();
}

Future<String> readTarballFile(String path, String name) async {
  final result = await Process.run(
    'tar',
    ['-O', '-xzf', path, name],
    stdoutEncoding: new Utf8Codec(allowMalformed: true),
  );
  if (result.exitCode != 0) throw 'Failed to read tarball contents.';

  return result.stdout;
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
bool isNewer(semver.Version a, semver.Version b, {bool pubSorted: true}) =>
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

final Set<String> knownMixedCasePackages = _knownMixedCasePackages.toSet();
final Set<String> blockedLowerCasePackages = _knownMixedCasePackages
    .map((s) => s.toLowerCase())
    .toSet()
      ..removeAll(_knownGoodLowerCasePackages);

const _knownMixedCasePackages = const [
  'Autolinker',
  'Babylon',
  'DartDemoCLI',
  'FileTeCouch',
  'Flutter_Nectar',
  'Google_Search_v2',
  'LoadingBox',
  'PolymerIntro',
  'Pong',
  'RAL',
  'Transmission_RPC',
  'ViAuthClient',
];
const _knownGoodLowerCasePackages = const [
  'babylon',
];

/// Sanity checks if the user would upload a package with a modified pub client
/// that skips these verifications.
/// TODO: share code to use the same validations as in
/// https://github.com/dart-lang/pub/blob/master/lib/src/validator/name.dart#L52
void validatePackageName(String name) {
  if (!_identifierExpr.hasMatch(name)) {
    throw new Exception(
        'Package name may only contain letters, numbers, and underscores.');
  }
  if (!_startsWithLetterOrUnderscore.hasMatch(name)) {
    throw new Exception('Package name must begin with a letter or underscore.');
  }
  if (_reservedWords.contains(name.toLowerCase())) {
    throw new Exception('Package name must not be a reserved word in Dart.');
  }
  final bool isLower = name == name.toLowerCase();
  final bool matchesMixedCase = knownMixedCasePackages.contains(name);
  if (!isLower && !matchesMixedCase) {
    throw new Exception('Package name must be lowercase.');
  }
  if (isLower && blockedLowerCasePackages.contains(name)) {
    throw new Exception('Name collision with mixed-case package. '
        'Please open new issue at: https://github.com/dart-lang/pub-dartlang-dart/issues/new');
  }
  if (!isLower &&
      matchesMixedCase &&
      !blockedLowerCasePackages.contains(name.toLowerCase())) {
    throw new Exception('Name collision with mixed-case package. '
        'Please open new issue at: https://github.com/dart-lang/pub-dartlang-dart/issues/new');
  }
}

List<List<T>> sliceList<T>(List<T> list, int limit) {
  if (list.length <= limit) return [list];
  final int maxPageIndex = (list.length - 1) ~/ limit;
  return new List.generate(maxPageIndex + 1,
      (p) => list.sublist(p * limit, min(list.length, (p + 1) * limit)));
}

/// Returns the candidates in priority order to display under the 'Example' tab.
List<String> exampleFileCandidates(String package) => [
      'example/lib/main.dart',
      'example/main.dart',
      'example/lib/$package.dart',
      'example/$package.dart',
      'example/${package}_example.dart',
      'example/example.dart',
    ];

/// Buffers for [duration] and then randomizes the order of the items in the
/// stream. For every single item, their final position would be in the range of
/// [maxPositionDiff] of its original position.
Stream<T> randomizeStream<T>(
  Stream<T> stream, {
  Duration duration: const Duration(minutes: 1),
  int maxPositionDiff: 1000,
  Random random,
}) {
  random ??= new Random.secure();
  final Stream trigger = new Stream.periodic(duration);
  final Stream<List<T>> bufferedStream = buffer(trigger).bind(stream);
  return bufferedStream.transform(new StreamTransformer.fromHandlers(
    handleData: (List<T> items, Sink<T> sink) {
      for (List<T> list in sliceList(items, maxPositionDiff)) {
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

  LastNTracker({int lastN: 1000}) : _n = lastN;

  void add(T d) {
    _lastItems.addLast(d);
    if (_lastItems.length > _n) _lastItems.removeFirst();
  }

  T get median => _getP(0.5);
  T get p90 => _getP(0.9);
  T get p99 => _getP(0.99);

  Map<T, int> toCounts() {
    return _lastItems.fold(<T, int>{}, (Map m, T item) {
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
    {int retryCount: 1}) async {
  http.Response result;
  Map<String, String> headers;
  if (context.traceId != null) {
    headers = {_cloudTraceContextHeader: context.traceId};
  }
  for (int i = 0; i <= retryCount; i++) {
    try {
      _logger.info('HTTP GET $url');
      result = await client.get(url, headers: headers);
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

/// Returns a valid `gs://` URI for a given [bucket] + [path] combination.
String bucketUri(Bucket bucket, String path) =>
    "gs://${bucket.bucketName}/$path";
