// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.utils;

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:appengine/appengine.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
// ignore: implementation_imports
import 'package:mime/src/default_extension_map.dart' as mime;
import 'package:path/path.dart' as p;
import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:pub_semver/pub_semver.dart' as semver;
import 'package:stream_transform/stream_transform.dart';

import 'configuration.dart' show envConfig;

export 'package:pana/pana.dart' show exampleFileCandidates;

final Duration twoYears = const Duration(days: 2 * 365);

/// The value `X-Cloud-Trace-Context`.
///
/// Standard trace header used by
/// [StackDriver](https://cloud.google.com/trace/docs/support) and supported by
/// Appengine.
const _cloudTraceContextHeader = 'X-Cloud-Trace-Context';

const fileAnIssueContent =
    'Please open an issue: https://github.com/dart-lang/pub-dev/issues/new';

final Logger _logger = Logger('pub.utils');
final _random = Random.secure();

final DateFormat shortDateFormat = DateFormat.yMMMd();

Future<T> withTempDirectory<T>(Future<T> Function(Directory dir) func,
    {String prefix = 'dart-tempdir'}) {
  return Directory.systemTemp.createTemp(prefix).then((Directory dir) {
    return func(dir).whenComplete(() {
      return dir.delete(recursive: true);
    });
  });
}

/// Returns null if version is invalid or cannot be normalized.
String canonicalizeVersion(String version) {
  if (version == null || version.trim().isEmpty) {
    return null;
  }
  // NOTE: This is a hack because [semver.Version.parse] does not remove
  // leading zeros for integer fields.
  semver.Version v;
  try {
    v = semver.Version.parse(version);
  } on FormatException catch (_) {
    return null;
  }
  final pre = v.preRelease != null && v.preRelease.isNotEmpty
      ? v.preRelease.join('.')
      : null;
  final build =
      v.build != null && v.build.isNotEmpty ? v.build.join('.') : null;

  final canonicalVersion =
      semver.Version(v.major, v.minor, v.patch, pre: pre, build: build);

  if (v != canonicalVersion) {
    return null;
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

final _reservedPackageNames = <String>[
  'core',
  'dart',
  'dart2js',
  'dart2native',
  'dartanalyzer',
  'dartaotruntime',
  'dartdevc',
  'dartfmt',
  'flutter_web',
  'flutter_web_test',
  'flutter_web_ui',
  'google_maps_flutter',
  'hummingbird',
  'in_app_purchase',
  'location_background',
  'math',
  'pub',
  'versions',
  'webview_flutter',
  // removed in https://github.com/dart-lang/pub-dev/issues/2853
  'fluttery',
  'fluttery_audio',
  'fluttery_seekbar',
].map(reducePackageName).toList();

/// Whether the [name] is (very similar) to a reserved package name.
bool matchesReservedPackageName(String name) =>
    _reservedPackageNames.contains(reducePackageName(name));

List<List<T>> _sliceList<T>(List<T> list, int limit) {
  if (list.length <= limit) return [list];
  final int maxPageIndex = (list.length - 1) ~/ limit;
  return List.generate(maxPageIndex + 1,
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
  random ??= Random.secure();
  final Stream trigger = Stream.periodic(duration);
  return stream.buffer(trigger).transform(StreamTransformer.fromHandlers(
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
  final Queue<T> _lastItems = Queue();
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
    final double sum = _lastItems.whereType<num>().fold(0.0, (a, b) => a + b);
    return sum / _lastItems.length;
  }

  T _getP(double p) {
    if (_lastItems.isEmpty) return null;
    final List<T> list = List.from(_lastItems);
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
      await Future.delayed(const Duration(seconds: 1));
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

final eventLoopLatencyTracker = LastNTracker<Duration>();

void trackEventLoopLatency() {
  final samplePeriod = const Duration(seconds: 3);
  void measure() {
    final sw = Stopwatch()..start();
    Timer(samplePeriod, () {
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
  Future<R> Function() body, {
  int maxAttempt = 3,
  bool Function(Object) shouldRetryOnError,
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
        await Future.delayed(sleep);
        continue;
      }
      rethrow;
    }
  }
}

/// Builds the Set-Cookie HTTP header value.
String buildSetCookieValue({
  @required String name,
  @required String value,
  @required DateTime expires,
}) {
  if (value == null || value == '') {
    value = '""';
  }
  return [
    '$name=$value',
    // Send cookie to anything under '/' required by '__Host-' prefix.
    'Path=/',
    // Max-Age takes precedence over 'Expires', this also has the benefit of
    // not being corrupted by client-side clock skew.
    'Max-Age=${expires.difference(DateTime.now()).inSeconds}',
    // Cookie expires when the session expires.
    'Expires=${HttpDate.format(expires)}',
    // Do not include the cookie in CORS requests, unless the request is a
    // top-level navigation to the site, as recommended in:
    // https://tools.ietf.org/html/draft-ietf-httpbis-rfc6265bis-02#section-8.8.2
    'SameSite=Lax',
    if (!envConfig.isRunningLocally)
      'Secure', // Only allow this cookie to be sent when making HTTPS requests.
    'HttpOnly', // Do not allow Javascript access to this cookie.
  ].join('; ');
}

/// Parses the Cookie HTTP header and returns a map of the values.
///
/// This always return a non-null [Map], even if the [cookieHeader] is empty.
Map<String, String> parseCookieHeader(String cookieHeader) {
  if (cookieHeader == null || cookieHeader.isEmpty) {
    return <String, String>{};
  }
  try {
    final r = <String, String>{};
    // The cookieString is separated by '; ', and contains 'name=value'
    // See: https://tools.ietf.org/html/rfc6265#section-5.4
    for (final s in cookieHeader.split('; ')) {
      final i = s.indexOf('=');
      if (i != -1) {
        r[s.substring(0, i)] = s.substring(i + 1);
      }
    }
    return r;
  } catch (_) {
    // Ignore broken cookies, we could throw a ResponseException instead, and
    // send the use a 400 error, this would be more correct. But unfortunately
    // it wouldn't help the user if the browser is sending a malformed 'cookie'
    // header. It would only serve to persistently break the site for the user.
    return <String, String>{};
  }
}

/// Returns a UUID in v4 format as a `String`.
///
/// If [bytes] is provided, it must be length 16 and have values between `0` and
/// `255` inclusive.
///
/// If [bytes] is not provided, it is generated using `Random.secure`.
String createUuid([List<int> bytes]) {
  bytes ??= List<int>.generate(16, (_) => _random.nextInt(256));
  if (bytes.length != 16) {
    throw ArgumentError('16 bytes expected, got: ${bytes.length}');
  }
  // See http://www.cryptosys.net/pki/uuid-rfc4122.html for notes
  bytes[6] = (bytes[6] & 0x0F) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;

  String formatByte(int byte) => byte.toRadixString(16).padLeft(2, '0');

  return [
    bytes.sublist(0, 4).map(formatByte).join(),
    bytes.sublist(4, 6).map(formatByte).join(),
    bytes.sublist(6, 8).map(formatByte).join(),
    bytes.sublist(8, 10).map(formatByte).join(),
    bytes.sublist(10).map(formatByte).join(),
  ].join('-');
}
